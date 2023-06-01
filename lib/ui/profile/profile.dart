import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';
import 'package:second_opinion_app/widgets/rounded_button_widget.dart';
import 'package:image_picker/image_picker.dart';
import '../../di/components/service_locator.dart';
import '../../widgets/progress_indicator_widget.dart';
import '../../widgets/textfield_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  ProfileStore _profileStore = getIt<ProfileStore>();

  File? _image;

  List<String> items = ['Male', 'Female'];
  String? selectedGender;

  bool isLbs = true;

  bool isCm = true;

  @override
  void initState() {
    _profileStore.getProfile().then((value) {
      popUpTheData().then((value) {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    popUpTheData();
    super.didChangeDependencies();
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
      backgroundColor: Colors.white10.withOpacity(0.1),
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
      'Profile',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return _profileStore.isProfileInProcess ? CustomProgressIndicatorWidget() : _buildMainContent();
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
                      _buildEmailField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildPhoneField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildGenderField(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildAgeField(),
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
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RoundedButtonWidget(
                          buttonText: 'Save',
                          buttonColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            final String age;
                            if (ageController.text.isEmpty) {
                              if (_profileStore.currentUserProfile?.age == null || _profileStore.currentUserProfile!.age!.isEmpty) {
                                age = '0';
                              } else {
                                age = _profileStore.currentUserProfile!.age!;
                              }
                            } else {
                              age = ageController.text;
                            }

                            _profileStore.updateProfile(
                                selectedGender ?? _profileStore.currentUserProfile!.gender!, int.parse(age), _image ?? null);
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
            if (_image == null && _profileStore.currentUserProfile?.profileImg == null)
              Image.asset(
                width: 90,
                'assets/images/profilePicture.png',
                fit: BoxFit.fitWidth,
              )
            else if (_profileStore.currentUserProfile?.profileImg != null)
              CachedNetworkImage(
                imageUrl: _profileStore.currentUserProfile!.profileImg!,
                width: 90,
                fit: BoxFit.fitWidth,
              ),
            if (_image != null)
              Image.file(
                width: 90,
                _image!,
                fit: BoxFit.fitWidth,
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
      child: TextFieldWidget(isReadOnly: true,
        hint: 'Enter Your Name',
        inputType: TextInputType.name,
        icon: Icons.person_outline_rounded,
        inputAction: TextInputAction.next,
        autoFocus: false,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        onTap: () {},
        textController: nameController,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFieldWidget(isReadOnly: true,
      hint: 'Enter Your Email',

      inputType: TextInputType.emailAddress,
      icon: Icons.email_outlined,
      inputAction: TextInputAction.next,
      autoFocus: false,
      imageIcon: 'assets/icons/Mail.png',
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: emailController,
    );
  }

  Widget _buildPhoneField() {
    return TextFieldWidget(
      hint: 'Enter Your Mobile Number',
      inputType: TextInputType.phone,
      icon: Icons.phone_outlined,
      imageIcon: 'assets/icons/Call.png',
      inputAction: TextInputAction.next,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: mobileController,
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
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value!;
          _profileStore.currentUserProfile!.gender = value;
          print(value);
        });
      },
    );
  }

  Widget _buildWeightField() {
    return TextFieldWidget(
      hint: 'Weight',
      inputType: TextInputType.number,
      imageIcon: 'assets/icons/Weight.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {_profileStore.currentUserProfile!.weight = value;},
      onFieldSubmitted: (value) {},
      textController: weightController,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            if (_profileStore.currentUserProfile!.weightUnit == 'pound') {
              _profileStore.currentUserProfile!.weightUnit = 'kg';
            } else {
              _profileStore.currentUserProfile!.weightUnit = 'pound';
            }
          });
        },
        icon: Text(
          _profileStore.currentUserProfile!.weightUnit != 'pound' ? 'kg' : 'lbs',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildHeightField() {
    return TextFieldWidget(
      hint: 'Height',
      inputType: TextInputType.number,
      icon: Icons.height_rounded,
      imageIcon: 'assets/icons/Scale.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {_profileStore.currentUserProfile!.height = value;},
      onFieldSubmitted: (value) {},
      textController: heightController,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            if (_profileStore.currentUserProfile!.heightUnit == 'feet') {
              _profileStore.currentUserProfile!.heightUnit = 'cm';
            } else {
              _profileStore.currentUserProfile!.heightUnit = 'feet';
            }
          });
        },
        icon: Text(
          _profileStore.currentUserProfile!.heightUnit != 'feet' ? 'cm' : 'ft',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildAgeField() {
    return Observer(builder: (context) {
      return TextFieldWidget(
        hint: 'Age',
        inputType: TextInputType.number,
        icon: Icons.person_outline_rounded,
        textController: ageController,
        inputAction: TextInputAction.next,
        onTap: () {},
        onChanged: (value) {

          _profileStore.currentUserProfile!.age = value;
        },
        onFieldSubmitted: (value) {},
      );
    });
  }

  Future<void> popUpTheData() async {
    print('object');
    if (_profileStore.isProfileInProcess) nameController = TextEditingController(text: _profileStore.currentUserProfile?.name ?? "");
    ;
    emailController = TextEditingController(text: _profileStore.currentUserProfile?.email ?? "");
    ;
    if (_profileStore.isProfileInProcess) {
      final gender = _profileStore.currentUserProfile?.gender?.toLowerCase();

      if (gender == "male") {
        selectedGender = "Male";
      } else if (gender == "female") {
        selectedGender = "Female";
      }
    }

    if (_profileStore.isProfileInProcess) ageController = TextEditingController(text: _profileStore.currentUserProfile?.age ?? "");
    ;
    if (_profileStore.isProfileInProcess) heightController = TextEditingController(text: _profileStore.currentUserProfile?.height ?? "");
    ;
    if (_profileStore.isProfileInProcess) weightController = TextEditingController(text: _profileStore.currentUserProfile?.weight ?? "");
    setState(() {});
  }
}
