import 'package:flutter/material.dart';
import 'package:second_opinion_app/widgets/roundedRectangle_widget.dart';
import 'package:second_opinion_app/widgets/textfield_widget.dart';

class UploadDocumentWidget extends StatefulWidget {
  const UploadDocumentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadDocumentWidget> createState() => _UploadDocumentWidgetState();
}

class _UploadDocumentWidgetState extends State<UploadDocumentWidget> {
  List<Map<String, dynamic>> certificateList = [{}];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }

  Widget _buildUploadWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      child: InkWell(
        onTap: () {},
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
    return TextFieldWidget(
      padding: EdgeInsets.zero,
      hint: 'Select User',
      inputType: TextInputType.name,
      icon: Icons.person_outline_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: TextEditingController(),
    );
  }

  Widget _buildFileNameField() {
    return TextFieldWidget(
      padding: EdgeInsets.zero,
      hint: 'File Name',
      inputType: TextInputType.name,
      icon: Icons.file_present_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: TextEditingController(),
    );
  }

  Widget _buildFileTypeField() {
    return TextFieldWidget(
      padding: EdgeInsets.zero,
      hint: 'File Type',
      inputType: TextInputType.name,
      icon: Icons.file_present_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: TextEditingController(),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Upload'),
      ),
    );
  }
}
