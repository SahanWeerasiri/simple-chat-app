import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: List1(
        data: [
          ListItem1Data(title: "Group1", icon: Icons.group, onPressed: () {}),
          ListItem1Data(
              title: "Group2", icon: Icons.group_outlined, onPressed: () {}),
        ],
        color: CustomColors().blueLighter,
      ),
    );
  }
}
