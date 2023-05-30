import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:second_opinion_app/models/profile/sub_profile_response.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';
import 'package:second_opinion_app/widgets/roundedRectangle_widget.dart';
import 'package:second_opinion_app/widgets/textfield_widget.dart';

import '../di/components/service_locator.dart';
import '../stores/report/report_store.dart';

class UploadDocumentWidget extends StatefulWidget {
  const UploadDocumentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadDocumentWidget> createState() => _UploadDocumentWidgetState();
}

class _UploadDocumentWidgetState extends State<UploadDocumentWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ReportStore _reportStore = getIt<ReportStore>();

  ProfileStore _profileStore = getIt<ProfileStore>();

  List<Map<String, dynamic>> certificateList = [{}];

  FilePickerResult? result;
  File? file;

  SubProfileResponse? selectedItem;

  TextEditingController fileNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Document Type',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildUploadWidget(),
                    _buildSelectUserField(),
                    _buildFileNameField(),
                    _buildFileTypeField(),
                    _buildButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      child: InkWell(
        onTap: () async {
          result = await FilePicker.platform.pickFiles();

          if (result != null) {
            _reportStore.documentFile = File(result!.files.single.path!);
          } else {
            // User canceled the picker
          }
        },
        child: RoundedRectangularWidget(
            dashPattern: [5, 3],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/uploadIcon.png',
                  width: 35,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Upload',
                  style:
                      Theme.of(context).textTheme.headlineMedium!.copyWith(color: Theme.of(context).primaryColor, fontSize: 15),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildSelectUserField() {
    return DropdownButtonFormField<SubProfileResponse>(
      validator: (value) {
        if (value == null) {
          return 'Please select user';
        }
        return null; // Return null if the value is valid
      },
      decoration: InputDecoration(
        hintText: 'Select User',
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
        prefixIcon: Image.asset('assets/icons/Person.png'),
      ),
      value: selectedItem,
      items:
          _profileStore.currentSubUserProfile!.subProfile!.map<DropdownMenuItem<SubProfileResponse>>((SubProfileResponse value) {
        return DropdownMenuItem<SubProfileResponse>(
          value: value,
          child: Text(value.name!),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedItem = value!;
          _reportStore.userId = value.id;
        });
      },
    );
  }

  Widget _buildFileNameField() {
    return TextFieldWidget(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter file name';
        }
        return null; // Return null if the value is valid
      },
      padding: EdgeInsets.zero,
      hint: 'File Name',
      imageIcon: 'assets/icons/File.png',
      inputType: TextInputType.name,
      icon: Icons.file_present_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {
        _reportStore.fileName = value;
      },
      onFieldSubmitted: (value) {},
      textController: fileNameController,
    );
  }

  Widget _buildFileTypeField() {
    List<String> items = ['Test Report', 'Prescription', 'Medical Report'];
    String? selectedItem;

    return DropdownButtonFormField<String>(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select file type';
        }
        else if(_reportStore.documentFile == null){
          return 'Please upload a file';
        }
        return null; // Return null if the value is valid
      },
      decoration: InputDecoration(
        hintText: 'File Type',
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
        prefixIcon: Image.asset('assets/icons/File.png'),
      ),
      value: selectedItem,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {

            _reportStore.fileType = value;

        });
      },
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if ((formKey.currentState!.validate())) {
            _reportStore.uploadReport();

            Navigator.pop(context);
          }
        },
        child: Text('Upload'),
      ),
    );
  }
}
