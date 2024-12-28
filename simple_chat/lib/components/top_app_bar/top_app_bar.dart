import 'package:flutter/material.dart';

class MallikaAppBar5 extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool backButton;
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final VoidCallback? backOnPressed;
  final List<IconButton> actions;
  final bool automaticLeading;
  const MallikaAppBar5(
      {super.key,
      this.automaticLeading = false,
      this.backButton = false,
      required this.title,
      this.backOnPressed,
      this.titleColor = Colors.white,
      this.backgroundColor = Colors.orange,
      this.actions = const []})
      : preferredSize = const Size.fromHeight(56.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        automaticallyImplyLeading: automaticLeading,
        foregroundColor: titleColor,
        leading: backButton
            ? IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: titleColor),
                onPressed: backOnPressed ?? () {},
              )
            : null,
        title: Text(
          title,
          style: TextStyle(color: titleColor),
        ),
        actions: actions);
  }
}
