import 'package:flutter/material.dart';
import '../../../constants/consts.dart';

class BottomNavBtn extends StatelessWidget {
  const BottomNavBtn(
      {super.key,
      required this.icon,
      required this.index,
      required this.currentIndex,
      required this.onPressed,
      this.iconColor = Colors.yellow,
      this.shadowColor = Colors.black});

  final IconData icon;
  final Color iconColor;
  final int index;
  final int currentIndex;
  final Color shadowColor;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes();
    appSizes.initSizes(context);
    return InkWell(
      onTap: () {
        onPressed(index);
      },
      child: Container(
          height: appSizes.getBlockSizeHorizontal(13),
          width: appSizes.getBlockSizeHorizontal(17),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              (currentIndex == index)
                  ? Positioned(
                      left: appSizes.getBlockSizeHorizontal(4),
                      bottom: appSizes.getBlockSizeHorizontal(1.5),
                      child: Icon(
                        icon,
                        color: shadowColor,
                        size: appSizes.getBlockSizeHorizontal(8),
                      ))
                  : Container(),
              AnimatedOpacity(
                opacity: (currentIndex == index) ? 1 : 0.5,
                duration: const Duration(microseconds: 300),
                curve: Curves.easeIn,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: appSizes.getBlockSizeHorizontal(8),
                ),
              )
            ],
          )),
    );
  }
}
