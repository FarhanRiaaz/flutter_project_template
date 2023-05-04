import 'package:flutter/material.dart';
import 'package:second_opinion_app/widgets/roundedRectangle_widget.dart';
import 'package:second_opinion_app/widgets/upload_document_widget.dart';

import '../../widgets/textfield_widget.dart';

class SecondOpinionScreen extends StatefulWidget {
  const SecondOpinionScreen({Key? key, required this.onBackPressed}) : super(key: key);
  final VoidCallback onBackPressed;

  @override
  State<SecondOpinionScreen> createState() => _SecondOpinionScreenState();
}

class _SecondOpinionScreenState extends State<SecondOpinionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onBackPressed(); // Call the callback function
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildLeadingButton(),
      centerTitle: true,
      title: _buildTitle(),
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        widget.onBackPressed();
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      'Second Opinion',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildBody() {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildFirstNameField()),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: _buildLastNameField()),
              ],
            ),
            _buildPhoneField(),
            _buildGenderField(),
            _buildDescriptionField(),
            _buildUploadWidget(),
            SizedBox(
              height: 20,
            ),
            _buildProceedButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextFieldWidget(
      hint: 'Enter Your Mobile Number',
      inputType: TextInputType.phone,
      icon: Icons.phone_outlined,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: mobileController,
    );
  }

  Widget _buildGenderField() {
    return TextFieldWidget(
      hint: 'Enter Your Gender',
      inputType: TextInputType.text,
      icon: Icons.female_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: genderController,
    );
  }

  Widget _buildFirstNameField() {
    return TextFieldWidget(
      hint: 'First Name',
      inputType: TextInputType.name,
      icon: Icons.person_outline_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: firstNameController,
    );
  }

  Widget _buildLastNameField() {
    return TextFieldWidget(
      hint: 'Last Name',
      inputType: TextInputType.name,
      icon: Icons.person_outline_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: LastNameController,
    );
  }

  Widget _buildDescriptionField() {
    return TextFieldWidget(
      hint: 'Description',
      inputType: TextInputType.text,
      maxLines: 3,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: descriptionController,
    );
  }

  Widget _buildUploadWidget() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      child: InkWell(
        onTap: () {
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
        child: RoundedRectangularWidget(
            dashPattern: [5, 3],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/uploadIcon.png',
                  width: 60,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Upload Documents',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Proceed'),
      ),
    );
  }
}
