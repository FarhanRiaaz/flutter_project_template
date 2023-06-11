import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';
import 'package:second_opinion_app/widgets/roundedRectangle_widget.dart';
import 'package:second_opinion_app/widgets/upload_document_widget.dart';

import '../../widgets/second_opinion_upload_widget.dart';
import '../../widgets/textfield_widget.dart';

class SecondOpinionScreen extends StatefulWidget {
  const SecondOpinionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SecondOpinionScreen> createState() => _SecondOpinionScreenState();
}

class _SecondOpinionScreenState extends State<SecondOpinionScreen> {
  TextEditingController diseaseController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  FilePickerResult? result;

  @override
  void dispose() {
    diseaseController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(backgroundColor: Colors.transparent,
      leading: _buildLeadingButton(),
      centerTitle: true,
      title: _buildTitle(),
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

  Widget _buildBody() {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
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
        Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Please Answer Following Questions',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      _buildDiseaseField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildDescriptionField(),
                      result == null ? _buildUploadWidget() : _buildPickedFileWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
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
                      Navigator.pushNamed(context, Routes.payment);

                    },
                    child: Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiseaseField() {
    return TextFieldWidget(
      hint: 'Enter Disease',
      inputType: TextInputType.text,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: diseaseController,
    );
  }

  Widget _buildDescriptionField() {
    return TextFieldWidget(
      hint: 'Description',
      inputType: TextInputType.text,
      maxLines: 6,
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
        onTap: ()async {
         result = await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
                      child: const SecondOpinionUploadDocumentWidget(),
                    ),
                  ));
         setState(() {

         });
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

  Widget _buildPickedFileWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      child: RoundedRectangularWidget(
        dashPattern: [5, 3],
        child: InkWell(
          onTap: () async {
            result = await FilePicker.platform.pickFiles();
            setState(() {});
            if (result != null   ) {


            } else {

            }
          },
          child: Center(
              child: result!.files[0].name.endsWith('.jpg') ||
                  result!.files[0].name.endsWith('.png') ||
                  result!.files[0].name.endsWith('.jpeg')
                  ? Image.file(File(result!.files[0].path!))
                  : CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/4208/4208479.png', // Replace with your placeholder image URL
              )),
        ),
      ),
    );
  }
}
