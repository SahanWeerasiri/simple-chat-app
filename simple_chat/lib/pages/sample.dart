import 'package:flutter/material.dart';
import '../components/list/design1/list1.dart';
import '../constants/consts.dart';
import '../components/list/design1/list_item_data.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return List1(
      height: 10,
      padding: 2,
      borderRadius: 2,
      color: Colors.greenAccent,
      data: [
        ListItem1Data(
            title: "Bottom Navigation 1",
            icon: Icons.topic,
            onPressed: () {
              Navigator.pushNamed(context, '/test_bottom_navigation_bar1');
            }),
        ListItem1Data(
            title: "App Bar 1",
            icon: Icons.home,
            onPressed: () {
              Navigator.pushNamed(context, '/test_app_bar1');
            }),
        ListItem1Data(
            title: "List View 1",
            icon: Icons.list,
            onPressed: () {
              Navigator.pushNamed(context, '/test_list_view1');
            }),
        ListItem1Data(
            title: "Custom Button 1",
            icon: Icons.touch_app,
            onPressed: () {
              Navigator.pushNamed(context, '/test_custom_button1');
            }),
        ListItem1Data(
            title: "Card 1",
            icon: Icons.card_giftcard,
            onPressed: () {
              Navigator.pushNamed(context, '/test_cards1');
            }),
        ListItem1Data(
            title: "Drawer 1",
            icon: Icons.menu,
            onPressed: () {
              Navigator.pushNamed(context, '/test_drawer1');
            }),
        ListItem1Data(
            title: "Box 1",
            icon: Icons.add_box,
            onPressed: () {
              Navigator.pushNamed(context, '/test_box1');
            }),
        ListItem1Data(
            title: "Dialogue 1",
            icon: Icons.message,
            onPressed: () {
              Navigator.pushNamed(context, '/test_dialogue1');
            }),
        ListItem1Data(
            title: "Loading Indicator 1",
            icon: Icons.hourglass_bottom,
            onPressed: () {
              Navigator.pushNamed(context, '/test_loading_indicator1');
            }),
        ListItem1Data(
            title: "Text Input 1",
            icon: Icons.text_fields,
            onPressed: () {
              Navigator.pushNamed(context, '/test_text_input1');
            }),
        ListItem1Data(
            title: "Text 1",
            icon: Icons.text_fields,
            onPressed: () {
              Navigator.pushNamed(context, '/test_text1');
            }),
      ],
    );
  }
}
