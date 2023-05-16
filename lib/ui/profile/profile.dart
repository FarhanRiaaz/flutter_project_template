import 'package:flutter/material.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';
import 'package:second_opinion_app/widgets/rounded_button_widget.dart';

import '../../di/components/service_locator.dart';
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
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();


  ProfileStore store = getIt<ProfileStore>();


  @override
  void initState() {
    store.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
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
      'Profile',
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
        Padding(
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
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RoundedButtonWidget(
                    buttonText: 'Save',
                    buttonColor: Theme.of(context).primaryColor,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPictureWidget() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/images/profilePicture.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
    );
  }

  Widget _buildNameField() {
    return Container(
      child: TextFieldWidget(
        hint: 'Enter Your Name',
        inputType: TextInputType.name,
        icon: Icons.person_outline_rounded,
        inputAction: TextInputAction.next,
        autoFocus: false,
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
        textController: nameController,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFieldWidget(
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
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: mobileController,
    );
  }

  Widget _buildGenderField() {
    return TextFieldWidget(
      hint: 'Enter Your Gender',
      imageIcon: 'assets/icons/Gender.png',
      inputType: TextInputType.text,
      icon: Icons.female_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: genderController,
    );
  }

  Widget _buildWeightField() {
    return TextFieldWidget(
      hint: 'Enter Your Weight',
      inputType: TextInputType.number,

      imageIcon: 'assets/icons/Weight.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: weightController,
    );
  }

  Widget _buildHeightField() {
    return TextFieldWidget(
      hint: 'Enter Your Height',
      inputType: TextInputType.number,
      icon: Icons.height_rounded,
      imageIcon: 'assets/icons/Scale.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: heightController,
    );
  }

  Widget _buildAgeField() {
    return TextFieldWidget(
      hint: 'Enter Your Age',
      inputType: TextInputType.number,
      icon: Icons.person_outline_rounded,
      textController: ageController,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
    );
  }
}
