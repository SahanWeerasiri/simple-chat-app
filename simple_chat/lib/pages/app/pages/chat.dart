import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: List1(
        data: [
          ListItem1Data(
              title: "Sahan",
              icon: Icons.person,
              onPressed: () {
                Navigator.pushNamed(context, "/chat_screen");
              }),
          ListItem1Data(
              title: "Asel",
              icon: Icons.person_2,
              onPressed: () {
                Navigator.pushNamed(context, "/chat_screen");
              }),
          ListItem1Data(
              title: "Hasindu",
              icon: Icons.person_2_outlined,
              onPressed: () {
                Navigator.pushNamed(context, "/chat_screen");
              }),
          ListItem1Data(
              title: "Nishan",
              icon: Icons.person_3,
              onPressed: () {
                Navigator.pushNamed(context, "/chat_screen");
              }),
        ],
        color: CustomColors().blueLighter,
      ),
    );
  }
}
