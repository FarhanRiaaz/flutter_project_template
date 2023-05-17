import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_opinion_app/widgets/rounded_button_widget.dart';
import 'package:flex_color_picker/flex_color_picker.dart' as flex;
import '../../widgets/textfield_widget.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  bool isCm = true;

  bool isLbs = true;

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
      'Add User',
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

  Widget _buildColorField() {
    return TextFieldWidget(
      onTap: () {
        flex.showColorPickerDialog(context, Color(0xFFFFFFFF));
      },
      hint: 'Select the Color for name',
      inputType: TextInputType.emailAddress,
      isReadOnly: true,
      icon: Icons.color_lens_outlined,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: emailController,
    );
  }

  Widget _buildGenderField() {
    List<String> items = ['Male', 'Female'];
    String? selectedGender;

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
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      textController: genderController,
    );
  }

  Widget _buildWeightField() {
    return TextFieldWidget(
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isLbs = !isLbs; // toggle between lbs and kgs
          });
        },
        icon: Text(
          isLbs ? 'lbs' : 'kgs',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
      hint: 'Weight',
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
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isCm = !isCm; // toggle between lbs and kgs
          });
        },
        icon: Text(
          isCm ? 'cm' : 'ft',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      ),
      hint: 'Height',
      inputType: TextInputType.number,
      imageIcon: 'assets/icons/Scale.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
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
