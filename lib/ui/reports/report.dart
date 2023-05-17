import 'dart:math';

import 'package:flutter/material.dart';

import '../../widgets/prescription_widget.dart';
import '../../widgets/upload_document_widget.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key, required this.onBackPressed}) : super(key: key);
  final VoidCallback onBackPressed;

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  List<Map<String, dynamic>> prescriptionList = List.generate(15, (index) {
    final random = Random();
    final date = DateTime.now().subtract(Duration(days: random.nextInt(30)));
    final doctorName =
        'Dr. ${String.fromCharCode(random.nextInt(26) + 65)}. ${String.fromCharCode(random.nextInt(26) + 97)}. ${String.fromCharCode(random.nextInt(26) + 97)}';
    final symptoms = ['Fever', 'Cough', 'Headache', 'Sore Throat', 'Fatigue'][random.nextInt(5)];
    return {'date': date, 'doctorName': doctorName, 'symptoms': symptoms};
  });

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
      floatingActionButton: _buildFloatingActionButton(),

    );
  }

  Widget _buildListView() {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 80),
      itemCount: prescriptionList.length,
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> prescription = prescriptionList[index];
        final DateTime dateTime = prescription['dateTime'] ?? DateTime.now();
        final String doctorName = prescription['doctorName'] ?? '';
        final String symptoms = prescription['symptoms'] ?? '';

        return PrescriptionWidget(
          symptoms: symptoms,
          dateTime: dateTime,
          doctorName: doctorName,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 8,
        );
      },
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Opacity(opacity: 0.25, child: Image.asset('assets/images/background/bottomRight.png')),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Opacity(opacity: 0.25, child: Image.asset('assets/images/background/topLeft.png')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: _buildListView(),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // leading: _buildLeadingButton(),
      title: _buildTitle(),
      centerTitle: true,
      //actions: _buildActions(),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[_buildAddButton()];
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const ImageIcon(
        AssetImage(
          'assets/icons/Headphones.png',
        ),
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget _buildTitle() {
    return Text(
      'Reports',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        child: ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
                        child: const UploadDocumentWidget(),
                      ),
                    ));
          },
          icon: Icon(Icons.add),
          label: Text('Add'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1ce0a3)),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(backgroundColor: Color(0xFF1ce0a3),
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
                    child: const UploadDocumentWidget(),
                  ),
                ));
      },
      child: Icon(Icons.add),
    );
  }
}
