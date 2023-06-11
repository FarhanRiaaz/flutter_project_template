import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:second_opinion_app/di/components/service_locator.dart';
import 'package:second_opinion_app/models/categories/category_instance_response.dart';
import 'package:second_opinion_app/stores/category/category_store.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';
import 'package:second_opinion_app/widgets/helper/DialogHelper.dart';
import 'package:second_opinion_app/widgets/progress_indicator_widget.dart';
import '../../models/categories/opinion_request.dart';
import '../../models/profile/sub_profile_response.dart';
import '../../widgets/mcq_selector_widget.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key, this.user, this.count}) : super(key: key);

  final SubProfileResponse? user;
  final int? count;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  CategoryStore _categoryStore = getIt<CategoryStore>();
  ProfileStore _profileStore = getIt<ProfileStore>();

  List<int> selectedOptions = [-1, -1, -1];

  int selectedOption = -1;

  OpinionSubmitRequest submitRequest = OpinionSubmitRequest();

  initialize() async {
    await _categoryStore.getFormByCategory(2);

    submitRequest.userId = widget.user!.id;

    submitRequest.form = 2;
    submitRequest.answers = [];
    for (Question question in _categoryStore.categoryInstanceResponse!.questions!) {
      submitRequest.answers!.add(Answer(question: question.id, type: question.getQuestionTypeString(question.type)));
    }
  }

  @override
  void initState() {
    initialize();
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
              Observer(builder: (context) {
                return Expanded(
                  child: !_categoryStore.isCategoriesInstanceInProcess
                      ? SingleChildScrollView(
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
                                      onPressed: () {
                                        print(submitRequest.toJson());
                                      },
                                      child: Text('Previous'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.width * 0.12,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        for (Answer answer in submitRequest.answers!) {
                                          if (answer.answer == null || answer.answer == '') {
                                            await DialogHelper.showCompletionDialog(
                                              context,
                                              'Complete Form',
                                              'Please fill in all the required fields.',
                                            );
                                            return;
                                          }
                                        }

                                        _categoryStore.submitSecondOpinion(submitRequest);

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
                        )
                      : CustomProgressIndicatorWidget(
                          color: Colors.white10,
                        ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
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
      widget.user!.name ?? '',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _categoryStore.categoryInstanceResponse?.questions?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            if (_categoryStore.categoryInstanceResponse!.questions![index].type == QuestionType.MCQ) {
              return McqWidget(
                  question: _categoryStore.categoryInstanceResponse!.questions![index].question!,
                  options: _categoryStore.categoryInstanceResponse!.questions![index].options!,
                  selectedOption: selectedOption,
                  onSelect: (selectedValue) {
                    submitRequest.answers![index].answer =
                        _categoryStore.categoryInstanceResponse!.questions![index].options![selectedValue].option;
                  });
            } else if (_categoryStore.categoryInstanceResponse!.questions![index].type == QuestionType.EditText) {
              return _buildTextEditQuestion(_categoryStore.categoryInstanceResponse!.questions![index].question!, (value) {
                submitRequest.answers![index].answer = value;
              });
            } else {
              return _buildDocument(_categoryStore.categoryInstanceResponse!.questions![index].question!, (pickedFile) {
                submitRequest.answers![index].answer = pickedFile;
              }
                  // Additional parameters for the specific type of question
                  );
            }
          },
        ),
      );
    });
  }

  _buildTextEditQuestion(String question, Function(String) onChanged) {
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
              onChanged: (value) {
                onChanged(value);
              },
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

  _buildDocument(String question, Function(String) onFilePicked) {
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
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: Colors.white,
              child: UploadWidgetProfileSetup(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  dropdown: DropdownButtonFormField<String>(
                    onChanged: (value) {},
                    items: const [
                      DropdownMenuItem(
                        value: 'Test Report',
                        child: Text('Test Report'),
                      ),
                      DropdownMenuItem(
                        value: 'Prescription',
                        child: Text('Prescription'),
                      ),
                      DropdownMenuItem(
                        value: 'Medical Report',
                        child: Text('Medical Report'),
                      ),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Type',
                      labelStyle: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onFilePicked: (file) {
                    onFilePicked(file.files.first.path!);
                  },
                  cert: {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String question, List<Option> option, int selectedOption, Function(int) onSelect) {
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
                    onSelect(value!);
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
          activeColor: Theme.of(context).primaryColor,
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

class UploadWidgetProfileSetup extends StatefulWidget {
  const UploadWidgetProfileSetup(
      {Key? key,
      this.dropdown,
      this.isCV = false,
      this.padding,
      this.onTextFieldValueChange,
      required this.onFilePicked,
      this.onRemoveButton,
      this.index,
      required this.cert,
      this.borderRadius,
      this.backgroundColor,
      this.label})
      : super(key: key);
  final EdgeInsetsGeometry? padding;
  final Function(String)? onTextFieldValueChange;
  final Function(FilePickerResult) onFilePicked;
  final Function(int)? onRemoveButton;
  final int? index;
  final Map<String, dynamic> cert;
  final bool isCV;
  final Color? backgroundColor;
  final DropdownButtonFormField? dropdown;
  final BorderRadius? borderRadius;
  final String? label;

  @override
  State<UploadWidgetProfileSetup> createState() => _UploadWidgetProfileSetupState();
}

class _UploadWidgetProfileSetupState extends State<UploadWidgetProfileSetup> {
  bool filePicked = false;
  String? fileName;
  late TextEditingController textEditingController;

  void cvFile() {
    if (widget.isCV) {
      textEditingController = TextEditingController(text: 'CV File');
      widget.onTextFieldValueChange!('CV File');
    } else {
      textEditingController = TextEditingController();
    }
  }

  void _onFilePicked(FilePickerResult result) {
    widget.onFilePicked(result);
    setState(() {
      fileName = result.files.single.name;
      filePicked = true;
    });
  }

  @override
  void initState() {
    cvFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutQuint,
      height: filePicked ? 160 : 90,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        borderRadius: widget.borderRadius != null ? BorderRadius.circular(12) : widget.borderRadius,
      ),
      child: Padding(
        padding: widget.padding == null ? const EdgeInsets.all(0) : widget.padding!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: widget.dropdown == null
                          ? !widget.isCV
                              ? TextFormField(
                                  onChanged: (value) {
                                    widget.onTextFieldValueChange!(value);
                                  },
                                  decoration: InputDecoration(
                                    label: const Text("File Name"),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    widget.label ?? 'CV File',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: widget.dropdown!,
                            ),
                    ),
                    IconButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowMultiple: false,
                          allowedExtensions: ['jpg', 'jpeg', 'png', 'docx', 'pdf'],
                        );
                        if (result != null) {
                          _onFilePicked(result);
                        }
                      },
                      icon: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Icon(
                          Icons.upload,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (filePicked)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.file_present_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      AnimatedContainer(
                        curve: Curves.easeOutQuint,
                        height: filePicked ? 70 : 0,
                        duration: const Duration(milliseconds: 1000),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Center(
                            child: Text(fileName ?? ''),
                          ),
                        ),
                      ),
                      const Expanded(
                          child: SizedBox(
                        height: 0,
                      )),
                      if (widget.onRemoveButton != null)
                        IconButton(
                            onPressed: () {
                              widget.onRemoveButton!(widget.index!);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ))
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
