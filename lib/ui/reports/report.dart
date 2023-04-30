import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/routes/routes.dart';
import '../../widgets/prescription_widget.dart';

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
    return WillPopScope(
      onWillPop: () async {
        widget.onBackPressed();
        return false;
      },
      child: Scaffold(
        body: _buildBody(),
        appBar: _buildAppBar(),
        floatingActionButton: ScaleTransition(
          scale: CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOutBack,
            reverseCurve: Curves.easeInOutBack.flipped,
          ),
          child: _buildFloatingActionButton(),
        ),
      ),
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
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0), child: _buildListView());
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildLeadingButton(),
      title: _buildTitle(),
      centerTitle: true,
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildNotificationButton(),
      _buildAvatarButton(),
      // _buildThemeButton(),
      //_buildLogoutButton(),
    ];
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        widget.onBackPressed();
      },
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
      icon: Stack(
        children: const [
          Icon(Icons.notifications_none_rounded),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: Colors.redAccent,
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  Widget _buildAvatarButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.profile);
        },
        customBorder: CircleBorder(),
        child: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/images/circleAvatar.png'),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      shape: CircleBorder(),
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Prescription',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
