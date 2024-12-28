import 'package:flutter/material.dart';

class ListItem1Data {
  final String title;
  final IconData icon;
  final IconData icon2;
  final Function() onPressed;
  final Color? color;
  const ListItem1Data(
      {required this.title,
      required this.icon,
      required this.onPressed,
      this.color,
      this.icon2 = Icons.arrow_forward});
}
