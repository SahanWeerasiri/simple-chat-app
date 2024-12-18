import 'package:flutter/material.dart';
import '../../components/buttons/custom_button_1/custom_button.dart';

class DialogFb2 extends StatelessWidget {
  final String text;
  final String subText;
  final IconData icon;
  final Color basicColor;
  final Color backgroundColor;
  final Color fontColor;
  final Color subTextFontColor;
  final Color btnBackColor;
  final Color btnTextColor;
  final VoidCallback? onPressed;
  final String btnText;
  const DialogFb2(
      {super.key,
      required this.text,
      required this.subText,
      required this.basicColor,
      required this.fontColor,
      required this.subTextFontColor,
      this.backgroundColor = Colors.white,
      this.icon = Icons.error,
      this.onPressed,
      this.btnText = "Next",
      this.btnBackColor = Colors.blue,
      this.btnTextColor = Colors.white});
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: basicColor.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: fontColor,
            ),
            Text(text,
                style: TextStyle(
                    color: fontColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 3.5,
            ),
            Text(subText,
                style: TextStyle(
                    color: subTextFontColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              label: btnText,
              onPressed: onPressed ?? () {},
              backgroundColor: btnBackColor,
              textColor: btnTextColor,
            )
          ],
        ),
      ),
    );
  }
}
