import 'package:flutter/material.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'From how long you are suffering from heart disease??',
      'options': ['Less then one year', 'One year', 'Two years', 'More then two years'],
    },
    {
      'question': 'Have you ever consult to doctor?',
      'options': [
        'Yes',
        'No',
      ],
    },
    {
      'question': 'Do you have any test reports of yours?',
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Please Answer Following Questions',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                _buildBody(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: ElevatedButton(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400)),
                        onPressed: () {},
                        child: Text('Previous'),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: ElevatedButton(
                        onPressed: () {Navigator.pushNamed(context,Routes.upload_screen);},
                        child: Text('Next'),
                      ),
                    ),
                  ],
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
      title: _buildTitle(),
      centerTitle: true,
    );
  }

  _buildTitle() {
    return Text(
      'Muhammad Zeeshan',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
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
        },
      ),
    );
  }

  Widget _buildCard(question, selectedOption) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(8.0),
      child: Padding(
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
                  selectedOption: selectedOption,
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
      ),
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
