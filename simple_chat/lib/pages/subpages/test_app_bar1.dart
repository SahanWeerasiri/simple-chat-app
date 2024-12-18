import 'package:flutter/material.dart';
import '../../components/top_app_bar/top_app_bar.dart';

class TestAppBar1 extends StatefulWidget {
  const TestAppBar1({super.key});

  @override
  State<TestAppBar1> createState() => _TestAppBar1State();
}

class _TestAppBar1State extends State<TestAppBar1> {
  final List<String> menuList = ["Home", "Search", "Setting", "Profile"];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MallikaAppBar5(
        backButton: true,
        backOnPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.red,
        titleColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                currentIndex = 1;
              });
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                currentIndex = 2;
              });
            },
            icon: const Icon(Icons.more_vert),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                currentIndex = 3;
              });
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        title: "Test App Bar 1",
      ),
      body: Center(
        child: Center(
          child: Text(menuList[currentIndex]),
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
