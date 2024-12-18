import 'package:flutter/material.dart';
import '../../components/drawer/simple_drawer/simple_drawer.dart';
import '../../../constants/consts.dart';
import '../../components/drawer/simple_drawer/drawer_index_controller.dart';

class TestDrawer1 extends StatefulWidget {
  const TestDrawer1({super.key});

  @override
  State<TestDrawer1> createState() => _TestDrawer1State();
}

class _TestDrawer1State extends State<TestDrawer1> {
  final List<Widget> pages = [
    const Text('Test Drawer 1'),
    const Text('Test Drawer 2'),
    const Text('Test Drawer 3'),
    const Text('Test Drawer 4'),
    const Text('Test Drawer 5'),
    const Text('Test Drawer 6'),
    const Text('Test Drawer 7'),
  ];
  DrawerIndexController drawerIndexController = DrawerIndexController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Drawer 1'),
      ),
      body: Center(
        child: Center(
          child: pages[drawerIndexController.getSelectedIndex()],
        ),
      ),
      drawer: DrawerFb1(
        drawerIndexController: drawerIndexController,
        drawerWidth: AppSizes.blockSizeHorizontal * 60,
        drawerRadius: 30,
        title: 'Test Drawer 1',
        textColor: Colors.white,
        selectedTextColor: Colors.blue,
        dividerColor: Colors.white70,
        items: [
          DrawerItems(
              index: 0,
              title: 'Item 1',
              icon: Icons.home,
              onTap: () {
                drawerIndexController.setSelectedIndex(0);
              }),
          DrawerItems(
              index: 1,
              title: 'Item 2',
              icon: Icons.search,
              onTap: () {
                drawerIndexController.setSelectedIndex(1);
              }),
          DrawerItems(
              index: 2,
              title: 'Item 3',
              icon: Icons.settings,
              onTap: () {
                drawerIndexController.setSelectedIndex(2);
              }),
          DrawerItems(
              index: 3,
              title: '',
              icon: Icons.person,
              onTap: () {
                drawerIndexController.setSelectedIndex(3);
              }),
          DrawerItems(
              index: 4,
              title: 'Item 5',
              icon: Icons.person,
              onTap: () {
                drawerIndexController.setSelectedIndex(4);
              }),
          DrawerItems(
              index: 5,
              title: 'Item 6',
              icon: Icons.person,
              onTap: () {
                drawerIndexController.setSelectedIndex(5);
              }),
        ],
        backgroundColor: Colors.blue,
      ),
    );
  }
}
