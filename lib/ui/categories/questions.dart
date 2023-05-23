import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:second_opinion_app/di/components/service_locator.dart';
import 'package:second_opinion_app/models/categories/category_instance_response.dart';
import 'package:second_opinion_app/stores/category/category_store.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  CategoryStore _categoryStore = getIt<CategoryStore>();

  List<int> selectedOptions = [-1, -1, -1];

  int selectedOption = -1;

  @override
  void initState() {
    _categoryStore.getFormByCategory(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
          Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
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
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.upload_screen);
                              },
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(backgroundColor: Colors.transparent,
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
  _buildTitle() {
    return Text(
      'Muhammad Zeeshan',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildBody() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _categoryStore.categoryInstanceResponse?.questions?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _categoryStore.categoryInstanceResponse!.questions![index].type == QuestionType.MCQ
                  ? _buildCard(_categoryStore.categoryInstanceResponse!.questions![index].question!,
                      _categoryStore.categoryInstanceResponse!.questions![index].options!, selectedOption)
                  : _buildTextEditQuestion(_categoryStore.categoryInstanceResponse!.questions![index].question!);
            },
          ),
        );
      }
    );
  }

  _buildTextEditQuestion(String question) {
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
              question,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).splashColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String question, List<Option> option, int selectedOption) {
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
              question,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ...List<Widget>.generate(
              option.length,
              (int i) {
                final currentOption = option[i];
                return OptionRadioTile(
                  option: currentOption.option!,
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
