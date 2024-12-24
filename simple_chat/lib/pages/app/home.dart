import 'package:simple_chat/components/dialogues/action_dialogue.dart';
import 'package:simple_chat/components/drawer/simple_drawer/drawer_index_controller.dart';
import 'package:simple_chat/components/drawer/simple_drawer/simple_drawer.dart';
import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/pages/app/pages/chat.dart';
import 'package:simple_chat/pages/app/pages/groups.dart';
import 'package:simple_chat/pages/app/pages/profile.dart';
import 'package:simple_chat/pages/app/pages/settings.dart';
import 'package:simple_chat/pages/app/pages/status.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _pages = const [
    Chat(),
    Status(),
    Groups(),
    Profile(),
    Settings()
  ];
  DrawerIndexController drawerIndexController = DrawerIndexController();
  int _selectedIndex = 0; // Add state variable to track selected index

  void logout() {
    showDialog(
        context: context,
        builder: (context) => DialogFb1(
              icon: Icons.logout,
              onYes: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              onNo: () {
                Navigator.pop(context);
              },
              topic: "Logout",
              subtext: "Do you really want to logout?",
              iconColor: CustomColors().blueLight,
              primaryColor: CustomColors().blue,
              accentColor: CustomColors().blueLight,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[
          _selectedIndex], // Use _selectedIndex instead of drawerIndexController
      drawer: DrawerFb1(
          title: "Chat App",
          items: [
            DrawerItems(
                index: 0,
                title: "Chats",
                icon: Icons.chat,
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                  drawerIndexController.setSelectedIndex(0);
                }),
            DrawerItems(
                index: 1,
                title: "Status",
                icon: Icons.star,
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                  drawerIndexController.setSelectedIndex(1);
                }),
            DrawerItems(
                index: 2,
                title: "Groups",
                icon: Icons.group,
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  drawerIndexController.setSelectedIndex(2);
                }),
            DrawerItems(
                index: 3,
                title: "",
                icon: Icons.chat,
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  drawerIndexController.setSelectedIndex(3);
                }),
            DrawerItems(
                index: 4,
                title: "Profile",
                icon: Icons.person,
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                  drawerIndexController.setSelectedIndex(4);
                }),
            DrawerItems(
                index: 5,
                title: "Settings",
                icon: Icons.settings,
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                  drawerIndexController.setSelectedIndex(5);
                }),
          ],
          backgroundColor: CustomColors().blueLight,
          textColor: Colors.white,
          selectedTextColor: CustomColors().blueDark,
          dividerColor: CustomColors().blueDark,
          drawerWidth: AppSizes.blockSizeHorizontal * 70,
          drawerRadius: 10,
          drawerIndexController: drawerIndexController),
      appBar: MallikaAppBar5(
        automaticLeading: true,
        title: "Chat App",
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add_contact");
              },
              icon: const Icon(Icons.add, color: Colors.white)),
          IconButton(
              onPressed: logout,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        backButton: false,
        backgroundColor: CustomColors().blue,
        titleColor: Colors.white,
      ),
      bottomNavigationBar: null,
    );
  }
}
