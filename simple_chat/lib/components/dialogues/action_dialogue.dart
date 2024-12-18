import 'package:flutter/material.dart';

class DialogFb1 extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onYes;
  final VoidCallback? onNo;
  final String topic;
  final String subtext;
  const DialogFb1(
      {super.key,
      this.topic = "Topic",
      this.subtext = "Sub text",
      this.icon = Icons.error,
      this.iconColor = Colors.black,
      this.onYes,
      this.onNo,
      this.primaryColor = const Color(0xff4338CA),
      this.accentColor = const Color(0xffffffff)});
  final Color primaryColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: primaryColor,
                radius: 25,
                child: Icon(
                  icon,
                  color: iconColor,
                )),
            const SizedBox(
              height: 15,
            ),
            Text(topic,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 3.5,
            ),
            Text(subtext,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(text: "Yes", onPressed: onYes ?? () {}),
                SimpleBtn1(
                  text: "No",
                  onPressed: onNo ?? () {},
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  const SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      super.key});
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            alignment: Alignment.center,
            side: WidgetStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: WidgetStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: WidgetStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}
