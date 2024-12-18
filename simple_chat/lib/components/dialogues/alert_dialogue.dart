import 'package:flutter/material.dart';
import 'dart:ui';

class CustomAlertDialog {
  static void showSimpleAlert(
    BuildContext context,
    String title,
    String content,
    Color? backgroundColor,
    Color? titleColor,
    Color? contentColor,
    IconData? icon,
    String? buttonText,
    Color? buttonColor,
    bool? cancelable,
    Color? iconColor,
  ) {
    showDialog(
      context: context,
      barrierDismissible: cancelable ?? true,
      barrierColor:
          Colors.black.withOpacity(0.5), // Add blur effect to background
      builder: (BuildContext context) {
        return BackdropFilter(
          // Add backdrop filter for blur
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: 1.0,
              child: AlertDialog(
                backgroundColor: backgroundColor,
                elevation: 24, // Add elevation to make dialog pop
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                title: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                icon: icon != null
                    ? Icon(
                        icon,
                        color: iconColor,
                      )
                    : null,
                content: Text(
                  content,
                  style: TextStyle(color: contentColor),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      buttonText ?? "OK",
                      style: TextStyle(color: buttonColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
