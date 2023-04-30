import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData? icon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLength: 40,
        maxLines: this.maxLines,
        keyboardType: this.inputType,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          prefixIcon: this.icon != null ? Icon(this.icon) : null,

          hintText: this.hint,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: hintColor),
          errorText: errorText,
          counterText: '',
          // icon: this.isIcon ? Icon(this.icon, color: iconColor) : null,
        ),
      ),
    );
  }

  const TextFieldWidget({
    Key? key,
    this.icon,
    this.maxLines = 1,
    required this.errorText,
    required this.textController,
    this.inputType,
    this.hint,
    this.isObscure = false,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);
}
