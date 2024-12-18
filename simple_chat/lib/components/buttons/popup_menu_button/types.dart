import 'package:flutter/material.dart';

class MenuItems {
  late String label;
  late IconData icon;
  late Function() onClick;

  MenuItems(String s, IconData i, Function() func) {
    label = s;
    icon = i;
    onClick = func;
  }
}
