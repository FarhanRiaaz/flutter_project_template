import 'package:flutter/material.dart';

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
      style: Theme
          .of(context)
          .textTheme
          .headlineMedium,
    );
  }

  Widget _buildBody() {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom),
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
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom + 8),
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: _buildProceedButton(),
              ),
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryField() {
    return TextFieldWidget(
      hint: 'Expiry Date',
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
    return
            SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: checked,
                    onChanged: (value) {
                      setState(() {
                        checked=!checked;
                      });
                    }),
                Text('Save for the future checkouts', style: Theme
                    .of(context)
                    .textTheme
                    .labelSmall),

              ],
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
