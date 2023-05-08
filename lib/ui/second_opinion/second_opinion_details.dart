import 'package:flutter/material.dart';

class SecondOpinionDetailScreen extends StatefulWidget {
  const SecondOpinionDetailScreen({Key? key}) : super(key: key);

  @override
  State<SecondOpinionDetailScreen> createState() => _SecondOpinionDetailScreenState();
}

class _SecondOpinionDetailScreenState extends State<SecondOpinionDetailScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'From how long you are suffering from heart disease??',
      'answer': 3,
      'options': ['Less then one year', 'One year', 'Two years', 'More then two years'],
    },
    {
      'question': 'Have you ever consult to doctor?',
      'answer': 1,
      'options': [
        'Yes',
        'No',
      ],
    },
    {
      'question': 'Do you have any test reports of yours?',
      'answer': 0,
      'options': ['Yes', 'No'],
    },
  ];

  List<int> selectedOptions = [-1, -1, -1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildUserDetails(),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildBookingDetail(),
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildBody(),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildBookingDetail(),
                ),

                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
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
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  _buildTitle() {
    return Text(
      'Second Opinion',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _buildBody() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Attributes',  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              final question = questions[index];
              int selectedOption = -1;
              return _buildCard(
                question,
                selectedOption,
              );
            }, separatorBuilder: (BuildContext context, int index) {return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ) ;},
          ),
        ],
      ),
    );
  }

  Widget _buildCard(question, selectedOption) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question['question'],
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ...List<Widget>.generate(
            question['options'].length,
            (int i) {
              final option = question['options'][i];
              return OptionRadioTile(
                option: option,
                selectedOption: question['answer'],
                value: i,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption = value!;
                    print(selectedOption);
                    print(i);
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> showRegistrationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 311,
            width: 290,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage("assets/images/background/backgroundPopUp.png"),
                fit: BoxFit.contain,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      child: Image.asset(
                        'assets/images/background/tick-icon.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Center(
                      child: Text(
                        "Thank You!",
                        style: TextStyle(fontSize: 18.0, color: Color(0xFF222B2C)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "You have successfully made second opinion with us",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Color(0xFFBEBEBE)),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserDetails() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'User Details',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                _buildCardRow('Name', 'Malik Zeeshan'),
                Divider(),
                _buildCardRow('Gender', 'Male'),
                Divider(),
                _buildCardRow('Date of Birth', '23/12/1996'),
                Divider(),
                _buildCardRow('Weight', '100 lbs'),
                Divider(),
                _buildCardRow('Height', '4.2 fts')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetail() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Booking Details',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                _buildCardRow('Field', 'Cardiologist'),
                Divider(),
                _buildCardRow('Doctor', 'Dr. Ali'),
                Divider(),
                _buildCardRow('Created On', 'March 22, 2023'),
                Divider(),
                _buildCardRowStatus('Status', 'Complete')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetail() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Payment Details',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                _buildCardRow('Payment Method', 'Card'),
                Divider(),
                _buildCardRow('Voucher', 'DS#675S'),
                Divider(),
                _buildCardRow('Discount', ''),
                Divider(),
                _buildCardRowStatus('Total Amount', '\$98.4')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCardRow(field, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(field, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
        Text(value, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCardRowStatus(field, status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(field, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey)),
        Container(
          decoration: BoxDecoration(
            color: status == 'Pending'
                ? Color(0xfffce7da)
                : status == 'Complete'
                    ? Color(0xffd4fae7)
                    : Color(0xfffadada),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            status,
            style: TextStyle(
              color: status == 'Pending'
                  ? Color(0xfffdae54)
                  : status == 'Complete'
                      ? Color(0xff1ce0a3)
                      : Color(0xFFe35959),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class OptionRadioTile extends StatelessWidget {
  final String option;
  final int selectedOption;
  final int value;
  final void Function(int?) onChanged;

  const OptionRadioTile({
    Key? key,
    required this.option,
    required this.selectedOption,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: value,
          groupValue: selectedOption,
          onChanged: onChanged,
        ),
        Text(
          option,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
