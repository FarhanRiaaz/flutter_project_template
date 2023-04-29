import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            _buildPictureWidget(),
            SizedBox(
              height: 20,
            ),
            _buildNameField(),
            _buildEmailField(),
            _buildPhoneField(),
            _buildGenderField(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildAgeField()),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: _buildDOBField()),
              ],
            ),
          ],
        ),
      ),
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
        errorText: '',
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
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: emailController,
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

  Widget _buildWeightField() {
    return TextFieldWidget(
      hint: 'Enter Your Weight',
      inputType: TextInputType.number,
      icon: Icons.monitor_weight_outlined,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: weightController,
    );
  }

  Widget _buildHeightField() {
    return TextFieldWidget(
      hint: 'Enter Your Height',
      inputType: TextInputType.number,
      icon: Icons.height_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
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
      errorText: '',
    );
  }

  Widget _buildDOBField() {
    return TextFieldWidget(
      hint: 'Enter Your Date of Birth',
      inputType: TextInputType.number,
      icon: Icons.calendar_month_rounded,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: dobController,
    );
  }
}
