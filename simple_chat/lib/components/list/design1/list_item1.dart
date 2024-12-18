import 'package:flutter/material.dart';
import '../../../constants/consts.dart';

class ListItem1 extends StatelessWidget {
  final double height;
  final Color color;
  final double padding;
  final double borderRadius;
  final Color textColor;
  final String title;
  final double shadowBlurRadius;
  final bool needArrow;
  final IconData icon;
  final Function() onPressed;
  const ListItem1(
      {super.key,
      this.height = 10,
      this.color = Colors.greenAccent,
      this.padding = 2,
      this.borderRadius = 2,
      this.textColor = Colors.black,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.needArrow = true,
      this.shadowBlurRadius = 10});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes();
    appSizes.initSizes(context);
    return Padding(
      padding: EdgeInsets.all(appSizes.getBlockSizeHorizontal(padding)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              appSizes.getBlockSizeHorizontal(borderRadius)),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: shadowBlurRadius,
            ),
          ],
        ),
        width: appSizes.getScreenWidth(),
        height: appSizes.getBlockSizeVertical(height),
        child: needArrow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: textColor),
                  Text(title, style: TextStyle(color: textColor)),
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(Icons.arrow_forward, color: textColor)),
                ],
              )
            : InkWell(
                onTap: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, color: textColor),
                    Text(title, style: TextStyle(color: textColor)),
                  ],
                ),
              ),
      ),
    );
  }
}
