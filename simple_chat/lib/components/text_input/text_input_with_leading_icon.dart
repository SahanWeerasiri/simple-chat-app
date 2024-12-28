import 'package:flutter/material.dart';
import '../../constants/consts.dart';
import '../../controllers/textController.dart';

class InputFieldFb3 extends StatefulWidget {
  final CredentialController inputController;
  final String hint;
  final IconData icon;
  final Color borderColor;
  final Color erroBorderColor;
  final Color focusedBorderColor;
  final Color enableBorderColor;
  final Color shadowColor;
  final Color hintColor;
  final bool isPassword;
  final TextInputType inputType;
  final String typeKey;
  final double fontSize;
  final Color textColor;

  const InputFieldFb3(
      {super.key,
      required this.inputController,
      required this.hint,
      required this.icon,
      required this.typeKey,
      this.borderColor = Colors.lightBlue,
      this.focusedBorderColor = Colors.blue,
      this.erroBorderColor = Colors.red,
      this.enableBorderColor = Colors.blue,
      this.shadowColor = Colors.blue,
      this.hintColor = Colors.white,
      this.isPassword = false,
      this.inputType = TextInputType.name,
      this.fontSize = 14,
      this.textColor = Colors.black});

  @override
  State<InputFieldFb3> createState() => _InputFieldFb3State();
}

class _InputFieldFb3State extends State<InputFieldFb3> {
  void setText(input) {
    widget.inputController.setCredentials(widget.typeKey, input);
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: widget.shadowColor.withOpacity(.15)),
      ]),
      child: TextField(
        onChanged: (value) {
          setText(value);
        },
        cursorColor: widget.enableBorderColor,
        obscureText: widget.isPassword,
        keyboardType: widget.inputType,
        style: TextStyle(fontSize: widget.fontSize, color: widget.textColor),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon as IconData?),
          filled: true,
          hintText: widget.hint,
          fillColor: widget.shadowColor,
          hintStyle: TextStyle(color: widget.hintColor.withOpacity(.75)),
          contentPadding: EdgeInsets.symmetric(
              vertical: 0.0, horizontal: AppSizes.blockSizeHorizontal * 10),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.focusedBorderColor, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.erroBorderColor, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.enableBorderColor, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
