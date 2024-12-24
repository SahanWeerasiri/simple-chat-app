import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final List<ContactModel> _contacts = [
    ContactModel("Contact 1", Icons.contact_page_outlined),
    ContactModel("Contact 2", Icons.contact_page_outlined),
  ];

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
      body: Center(
        child: List1(
          data: _contacts
              .map((contact) => ListItem1Data(
                  title: contact.name, icon: contact.icon, onPressed: () {}))
              .toList(),
          color: CustomColors().blueLighter,
        ),
      ),
    );
  }
}

class ContactModel {
  final String name;
  final IconData icon;
  ContactModel(this.name, this.icon);
}
