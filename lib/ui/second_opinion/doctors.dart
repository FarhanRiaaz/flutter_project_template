import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_opinion_app/widgets/doctors_widget.dart';

import '../../utils/routes/routes.dart';
import '../../widgets/prescription_widget.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List<Map<String, dynamic>> prescriptionList = List.generate(15, (index) {
    final random = Random();
    final date = DateTime.now().subtract(Duration(days: random.nextInt(30)));
    final doctorName =
        'Dr. ${String.fromCharCode(random.nextInt(26) + 65)}. ${String.fromCharCode(random.nextInt(26) + 97)}. ${String.fromCharCode(random.nextInt(26) + 97)}';
    final specializations = ['Cardiology', 'Neurology', 'Oncology', 'Dermatology', 'Endocrinology'][random.nextInt(5)];
    final statusOptions = ['Pending', 'Complete', 'No Read Message'];
    final status = statusOptions[random.nextInt(3)];
    return {'date': date, 'doctorName': doctorName, 'symptoms': specializations, 'status': status};
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppBar(),
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
        final String status = prescription['status'] ?? '';

        return DoctorsWidget(
          status: status,
          specialization: symptoms,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: _buildListView(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildLeadingButton(),
      title: _buildTitle(),
      centerTitle: true,
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      'Second Opinion',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildSearchBarWithButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFCCD2D8),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
