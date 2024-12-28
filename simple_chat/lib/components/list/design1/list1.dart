import 'package:flutter/material.dart';
import 'list_item1.dart';
import 'list_item_data.dart';

class List1 extends StatelessWidget {
  final List<ListItem1Data> data;
  final double height;
  final double padding;
  final double borderRadius;
  final Color color;
  const List1(
      {super.key,
      required this.data,
      this.height = 10,
      this.padding = 2,
      this.borderRadius = 2,
      this.color = Colors.greenAccent});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data
          .map((entry) => ListItem1(
                title: entry.title,
                icon: entry.icon,
                onPressed: entry.onPressed,
                height: height,
                padding: padding,
                borderRadius: borderRadius,
                color: entry.color ?? color,
                icon2: entry.icon2,
              ))
          .toList(),
    );
  }
}
