import 'package:flutter/material.dart';
import 'package:simple_chat/constants/consts.dart';
import '../../../components/buttons/custom_button_1/custom_button.dart';

class DialogResponse extends StatelessWidget {
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
  final VoidCallback? onPressedAccepted;
  final VoidCallback? onPressedRejected;
  final String btnText;
  const DialogResponse(
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
      this.btnTextColor = Colors.white,
      required this.onPressedAccepted,
      required this.onPressedRejected});
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: AppSizes().getBlockSizeHorizontal(60),
        height: AppSizes().getBlockSizeHorizontal(60),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 15,
            ),
            Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  label: "Accept",
                  onPressed: onPressedAccepted ?? () {},
                  backgroundColor: Colors.tealAccent,
                  textColor: CustomColors().blueDark,
                ),
                CustomButton(
                  label: "Reject",
                  onPressed: onPressedRejected ?? () {},
                  backgroundColor: Colors.redAccent,
                  textColor: CustomColors().blueDark,
                )
              ],
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
