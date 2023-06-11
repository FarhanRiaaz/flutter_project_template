import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:second_opinion_app/di/components/service_locator.dart';
import 'package:second_opinion_app/models/profile/sub_profile_request.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';
import 'package:second_opinion_app/widgets/rounded_button_widget.dart';
import 'package:flex_color_picker/flex_color_picker.dart' as flex;
import '../../widgets/textfield_widget.dart';
import '../models/profile/sub_profile_response.dart';
import '../widgets/progress_indicator_widget.dart';

//Todo Profile Image

class SubUserProfile extends StatefulWidget {
  const SubUserProfile({Key? key, required this.subProfileResponse}) : super(key: key);
  final SubProfileResponse subProfileResponse;

  @override
  State<SubUserProfile> createState() => _SubUserProfileState();
}

class _SubUserProfileState extends State<SubUserProfile> {
  List<String> items = ['Male', 'Female'];
  String? selectedGender;
  Color selectedColor = Color(0xFFFFFFFF);
  TextEditingController nameController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  ProfileStore _profileStore = getIt<ProfileStore>();
  File? _image;

  void initializeScreen() {
    setState(() {
      nameController.text = widget.subProfileResponse.name ?? '';
      colorController.text = widget.subProfileResponse.color ?? '';
      if (widget.subProfileResponse.color != null || widget.subProfileResponse.color!.isNotEmpty)
        selectedColor =
            Color(int.parse('0xFF${widget.subProfileResponse.color!.contains('#') ? '000000' : widget.subProfileResponse.color!}'));

      final gender = widget.subProfileResponse.gender?.toLowerCase();

      if (gender == "male") {
        selectedGender = "Male";
      } else if (gender == "female") {
        selectedGender = "Female";
      }

      // if (widget.subProfileResponse.gender!.isNotEmpty) {
      //   selectedGender = widget.subProfileResponse.gender?.toUpperCase() ?? 'MALE';
      // } else {
      //   selectedGender = 'MALE';
      // }
      dobController.text = widget.subProfileResponse.age ?? '';
      weightController.text = widget.subProfileResponse.weight ?? '';
      heightController.text = widget.subProfileResponse.height ?? '';
      relationshipController.text = widget.subProfileResponse.relationShip ?? '';
    });
  }

  @override
  void initState() {
    initializeScreen();
    _profileStore.subProfileRequest = SubProfileRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
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
      'Sub User',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return _profileStore.isUpdateSubProfileAddInProcess ? CustomProgressIndicatorWidget() : _buildMainContent();
    });
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPictureWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _buildNameField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildColorField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildGenderField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildRelationshipField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildDOBField(),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: _buildWeightField()),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: _buildHeightField()),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RoundedButtonWidget(
                          buttonText: 'Save',
                          buttonColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            _profileStore.updateSubUserProfile(widget.subProfileResponse.id.toString());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _profileStore.subProfileRequest?.profileImg = _image;
      });
    }
  }

  Widget _buildPictureWidget() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Choose from gallery'),
                    onTap: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text('Take a photo'),
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            if (_image == null && widget.subProfileResponse.profileImg == null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/profilePicture.png',
                  width: 90,
                  fit: BoxFit.fitWidth,
                ),
              )
            else if (widget.subProfileResponse.profileImg != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.subProfileResponse.profileImg!,
                  width: 90,
                  fit: BoxFit.fitWidth,
                ),
              ),
            if (_image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _image!,
                  width: 90,
                  fit: BoxFit.fitWidth,
                ),
              ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Container(
      child: TextFieldWidget(
        isReadOnly: true,
        hint: 'Enter Your Name',
        inputType: TextInputType.name,
        icon: Icons.person_outline_rounded,
        inputAction: TextInputAction.next,
        autoFocus: false,
        onChanged: (value) {
          _profileStore.subProfileRequest!.name = value;
        },
        onFieldSubmitted: (value) {},
        textController: nameController,
      ),
    );
  }

  Widget _buildColorField() {
    return TextFieldWidget(
      onTap: () async {
        final pickedColor = await flex.showColorPickerDialog(context, selectedColor);
        if (pickedColor != null) {
          setState(() {
            selectedColor = pickedColor;
            colorController.text = pickedColor.hex.toString();
            _profileStore.subProfileRequest!.color = colorController.text;
          });
        }
      },
      hint: 'Select the Color for name',
      inputType: TextInputType.emailAddress,
      isReadOnly: true,
      icon: Icons.color_lens_outlined,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {
        _profileStore.subProfileRequest!.color = value;
      },
      onFieldSubmitted: (value) {},
      textController: colorController,
      textStyle: TextStyle(color: selectedColor),
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Gender',
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
        prefixIcon: Image.asset('assets/icons/Gender.png'),
      ),
      value: selectedGender,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value!;
          _profileStore.subProfileRequest!.gender = value;
        });
      },
    );
  }

  Widget _buildRelationshipField() {
    return TextFieldWidget(
      hint: 'Enter Relationship',
      inputType: TextInputType.text,
      icon: Icons.person_outline_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {
        _profileStore.subProfileRequest!.relationship = value;
      },
      onFieldSubmitted: (value) {},
      textController: relationshipController,
    );
  }

  Widget _buildWeightField() {
    return TextFieldWidget(
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            if (_profileStore.subProfileRequest!.weightUnit == 'pound') {
              _profileStore.subProfileRequest!.weightUnit = 'kg';
            } else {
              _profileStore.subProfileRequest!.weightUnit = 'pound';
            }
          });
        },
        icon: Text(
          _profileStore.subProfileRequest!.weightUnit != 'pound' ? 'kg' : 'lbs',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
      hint: 'Weight',
      inputType: TextInputType.number,
      imageIcon: 'assets/icons/Weight.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {
        _profileStore.subProfileRequest!.weight = value;
      },
      onFieldSubmitted: (value) {},
      textController: weightController,
    );
  }

  Widget _buildHeightField() {
    return TextFieldWidget(
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            if (_profileStore.subProfileRequest!.heightUnit == 'feet') {
              _profileStore.subProfileRequest!.heightUnit = 'cm';
            } else {
              _profileStore.subProfileRequest!.heightUnit = 'feet';
            }
          });
        },
        icon: Text(
          _profileStore.subProfileRequest!.heightUnit != 'feet' ? 'cm' : 'ft',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
      hint: 'Height',
      inputType: TextInputType.number,
      imageIcon: 'assets/icons/Scale.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {
        _profileStore.subProfileRequest!.height = value;
      },
      onFieldSubmitted: (value) {},
      textController: heightController,
    );
  }

  Widget _buildDOBField() {
    return TextFieldWidget(
      imageIcon: 'assets/icons/Calender2.png',
      isReadOnly: true,
      onTap: () async {
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (selectedDate != null) {
          dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
          _profileStore.subProfileRequest!.age = dobController.text;
        }
      },
      hint: 'Enter Your Date of Birth',
      inputType: TextInputType.number,
      icon: Icons.calendar_month_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: dobController,
    );
  }
}
