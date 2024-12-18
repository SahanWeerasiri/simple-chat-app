import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MallikaAppBar5(
        automaticLeading: true,
        title: "Chat App - Add Contact",
        backButton: false,
        backgroundColor: CustomColors().blue,
        titleColor: Colors.white,
      ),
      body: const Center(
        child: Text("Add Contact"),
      ),
      bottomNavigationBar: null,
    );
  }
}
