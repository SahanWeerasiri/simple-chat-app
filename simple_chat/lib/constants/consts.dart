import 'package:flutter/material.dart';

class CustomTextInputTypes {
  final String username = "USERNAME";
  final String password = "PASSWORD";
  final String confirmPassword = "CONFIRM_PASSWORD";
  final String text = "TEXT";
  final String name = "NAME";
}

class CustomColors {
  final Color blueLight = const Color.fromARGB(255, 20, 153, 255);
  final Color blue = const Color.fromARGB(255, 0, 84, 210);
  final Color blueDark = const Color.fromARGB(255, 0, 14, 121);
  final Color blueLighter = const Color.fromARGB(255, 117, 204, 255);

  final Color greyHint = const Color.fromARGB(255, 62, 62, 62);

  final List<Color> gradientForBottomAppBar = [
    const Color.fromARGB(255, 20, 153, 255).withOpacity(0.8),
    const Color.fromARGB(255, 20, 153, 255).withOpacity(0.6),
    const Color.fromARGB(255, 20, 153, 255).withOpacity(0.3),
    Colors.transparent,
  ];
  final Color bottomNavigationColor = const Color.fromARGB(255, 1, 12, 95);
}

class AppSizes {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void initSizes(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  double getBlockSizeHorizontal(double percentage) {
    return blockSizeHorizontal * percentage;
  }

  double getBlockSizeVertical(double percentage) {
    return blockSizeVertical * percentage;
  }

  double getScreenWidth() {
    return screenWidth;
  }

  double getScreenHeight() {
    return screenHeight;
  }
}

class AnimatedPositionedLeftValue {
  double animatedPositionedLeftValue(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return AppSizes.blockSizeHorizontal * 5.5;
      case 1:
        return AppSizes.blockSizeHorizontal * 22.5;
      case 2:
        return AppSizes.blockSizeHorizontal * 39.4;
      case 3:
        return AppSizes.blockSizeHorizontal * 56.5;
      case 4:
        return AppSizes.blockSizeHorizontal * 73.5;
      default:
        return 0;
    }
  }
}

class DrawerItems {
  final int index;
  final String title;
  final IconData icon;
  final Function() onTap;
  DrawerItems(
      {required this.index,
      required this.title,
      required this.icon,
      required this.onTap});
}

const String BASE = "http://192.168.137.215:3000";

class ContactDetails {
  final String name;
  final int uid;
  final String img;
  ContactDetails({required this.name, required this.uid, required this.img});
}

class StatusDetails {
  final String name;
  final int statusId;
  final String messege;
  StatusDetails(
      {required this.name, required this.statusId, required this.messege});
}

class Request {
  final String name;
  final int requestId;
  final String img;
  final String state;
  final String timestamp;
  final int senderId;
  Request(
      {required this.name,
      required this.requestId,
      required this.timestamp,
      required this.state,
      required this.img,
      this.senderId = 0});
}

class MyProfile {
  final String name;
  final int uid;
  MyProfile({required this.uid, required this.name});
}
