import 'package:simple_chat/pages/app/home.dart';
import 'package:simple_chat/pages/app/pages/add_contact.dart';
import 'package:simple_chat/pages/app/pages/chat.dart';
import 'package:simple_chat/pages/app/pages/chat_screen.dart';
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
        '/chat': (context) => const Chat(),
        '/groups': (context) => const Groups(),
        '/status': (context) => const Status(),
        '/add_contact': (context) => const AddContact(),
        '/settings': (context) => const Settings(),
        '/profile': (context) => const Profile(),
        '/chat_screen': (context) => const ChatScreen(),
      },
    );
  }
}
