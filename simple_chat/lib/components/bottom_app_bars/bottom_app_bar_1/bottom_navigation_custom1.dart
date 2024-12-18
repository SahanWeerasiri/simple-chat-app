import 'package:flutter/material.dart';
import '../../../constants/consts.dart';
import './bottom_nav_button_1.dart';
import './clipper1.dart';
import './menuController.dart';

class BottomNavigationCustom1 extends StatefulWidget {
  final List<BottomNavBtn> navBtnList;
  final CustomMenuController menuController;
  final List<Color> gradient;
  final Color baseColor;
  final Color backgroundColor;
  final double animatedPositionedLeftValue;
  const BottomNavigationCustom1(
      {super.key,
      required this.navBtnList,
      required this.menuController,
      this.gradient = const [
        Color.fromRGBO(255, 235, 59, 204), // Colors.yellow with 0.8 opacity
        Color.fromRGBO(255, 235, 59, 128), // Colors.yellow with 0.5 opacity
        Colors.transparent,
      ],
      this.baseColor = Colors.yellow,
      this.backgroundColor = const Color.fromARGB(255, 78, 78, 78),
      required this.animatedPositionedLeftValue});

  @override
  State<StatefulWidget> createState() => _BottomNavigationCustom1State();
}

class _BottomNavigationCustom1State extends State<BottomNavigationCustom1> {
  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes();
    appSizes.initSizes(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(appSizes.getBlockSizeHorizontal(4.5), 0,
          appSizes.getBlockSizeHorizontal(4.5), 20),
      child: Material(
        color: Colors.transparent,
        elevation: 10,
        child: Container(
            width: appSizes.getScreenWidth(),
            height: appSizes.getBlockSizeHorizontal(18),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: appSizes.getBlockSizeHorizontal(3),
                  right: appSizes.getBlockSizeHorizontal(3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [for (var btn in widget.navBtnList) btn],
                  ),
                ),
                AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.decelerate,
                    left: widget.animatedPositionedLeftValue,
                    child: Column(
                      children: [
                        Container(
                          height: appSizes.getBlockSizeHorizontal(1.0),
                          width: appSizes.getBlockSizeHorizontal(12),
                          decoration: BoxDecoration(
                              color: widget.baseColor,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        ClipPath(
                          clipper: MyCustomClipprer1(),
                          child: Container(
                            height: AppSizes.blockSizeHorizontal * 15,
                            width: AppSizes.blockSizeHorizontal * 12,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: widget.gradient,
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
