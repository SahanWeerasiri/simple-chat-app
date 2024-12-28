import 'package:simple_chat/pages/app/home.dart';
import 'package:simple_chat/pages/app/pages/add_contact.dart';
import 'package:simple_chat/pages/app/pages/add_group.dart';
import 'package:simple_chat/pages/app/pages/add_members.dart';
import 'package:simple_chat/pages/app/pages/chat.dart';
import 'package:simple_chat/pages/app/pages/chat_screen.dart';
import 'package:simple_chat/pages/app/pages/group_info.dart';
import 'package:simple_chat/pages/app/pages/groups.dart';
import 'package:simple_chat/pages/app/pages/profile.dart';
import 'package:simple_chat/pages/app/pages/settings.dart';
import 'package:simple_chat/pages/app/pages/status.dart';
import 'package:simple_chat/pages/app/signup.dart';
import 'package:flutter/material.dart';
import 'pages/app/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup(),
        '/home': (context) => const Home(),
        '/chat': (context) => const Chat(
              uid: 0,
            ),
        '/groups': (context) => const Groups(
              uid: 0,
            ),
        '/status': (context) => const Status(
              uid: 0,
            ),
        '/add_contact': (context) => const AddContact(),
        '/settings': (context) => const Settings(),
        '/profile': (context) => const Profile(
              uid: 0,
            ),
        '/chat_screen': (context) => const ChatScreen(),
        '/create_group': (context) => const AddGroup(),
        '/group/add-members': (context) => const AddMembers(),
        '/group/info': (context) => const GroupInfo(),
      },
    );
  }
}
