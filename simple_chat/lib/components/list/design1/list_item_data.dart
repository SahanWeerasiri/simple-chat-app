import 'package:flutter/material.dart';

class ListItem1Data {
  final String title;
  final IconData icon;
  final Function() onPressed;
  const ListItem1Data(
      {required this.title, required this.icon, required this.onPressed});
}
