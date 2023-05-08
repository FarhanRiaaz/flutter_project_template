import 'package:flutter/material.dart';

import '../../utils/routes/routes.dart';
import '../../widgets/textfield_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCardNumberField(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildExpiryField()),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: _buildCvvField()),
                      ],
                    ),
                    _buildNameField(),
                    _buildCheckBox()
                  ],
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: MediaQuery.of(context).viewInsets.bottom + 8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: _buildProceedButton(),
                  ),
                ),
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryField() {
    return TextFieldWidget(
      hint: 'Expiry Date',
      imageIcon: 'assets/icons/Calender2.png',
      inputType: TextInputType.visiblePassword,
      icon: Icons.phone_outlined,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: cardExpiryController,
    );
  }

  Widget _buildCvvField() {
    return TextFieldWidget(
      hint: 'CVV',
      imageIcon: 'assets/icons/CreditCard.png',
      inputType: TextInputType.number,
      icon: Icons.credit_card,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: cvvController,
    );
  }

  Widget _buildCardNumberField() {
    return TextFieldWidget(
      hint: 'Card Number',
      inputType: TextInputType.number,
      icon: Icons.credit_card,
      imageIcon: 'assets/icons/CreditCard.png',
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: cvvController,
    );
  }

  Widget _buildNameField() {
    return TextFieldWidget(
      hint: 'Name',
      inputType: TextInputType.name,
      imageIcon: 'assets/icons/Person.png',
      icon: Icons.person,
      inputAction: TextInputAction.next,
      autoFocus: false,
      onChanged: (value) {},
      onFieldSubmitted: (value) {},
      errorText: '',
      textController: cvvController,
    );
  }

  Widget _buildCheckBox() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            checkColor: Colors.white,
            value: checked,
            onChanged: (value) {
              setState(() {
                checked = !checked;
              });
            },
          ),
          Text('Save for the future checkouts', style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () async {await showCongradulationsDialog(context);
          Navigator.pushNamed(context, Routes.home);},
        child: Text('Pay Now'),
      ),
    );
  }

  Future<void> showCongradulationsDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: 311,
            width: 290,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage("assets/images/background/backgroundPopUp.png"),
                fit: BoxFit.contain,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      child: Image.asset(
                        'assets/images/background/tick-icon.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Center(
                      child: Text(
                        "Thank You!",
                        style: TextStyle(fontSize: 18.0, color: Color(0xFF222B2C)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "You have successfully made second opinion with us",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Color(0xFFBEBEBE)),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
