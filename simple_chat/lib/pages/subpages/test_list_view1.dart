import 'package:flutter/material.dart';
import '../../components/list/design1/list1.dart';
import '../../components/list/design1/list_item_data.dart';

class TestListView1 extends StatelessWidget {
  const TestListView1({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(String title) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(title)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("List View 1")),
      body: List1(
        data: [
          ListItem1Data(
              title: "Item 1",
              icon: Icons.home,
              onPressed: () => onPressed("Item 1")),
          ListItem1Data(
              title: "Item 2",
              icon: Icons.settings,
              onPressed: () => onPressed("Item 2")),
          ListItem1Data(
              title: "Item 3",
              icon: Icons.person,
              onPressed: () => onPressed("Item 3")),
        ],
        height: 10,
        padding: 2,
        borderRadius: 2,
        color: Colors.greenAccent,
      ),
      bottomNavigationBar: null,
    );
  }
}
