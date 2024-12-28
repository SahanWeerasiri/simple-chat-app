import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/api/contacts_api.dart';

class Chat extends StatefulWidget {
  final int uid;

  const Chat({super.key, required this.uid});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late List<ContactDetails> _contacts = [];
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchContacts(); // Call a separate method without `await`
  }

  Future<void> _fetchContacts() async {
    try {
      Map<String, dynamic> map =
          await ContactApiService().getMyContacts(widget.uid);
      if (map['status']) {
        List<ContactDetails> contacts = (map['data'] as List).map((element) {
          return ContactDetails(
            uid: element['uid'],
            name: element['u_name'],
            img: element['img'],
          );
        }).toList();
        setState(() {
          _contacts = contacts; // Update the state with fetched contacts
          _isLoading = false; // Set loading to false
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(map['messege']),
              backgroundColor: Colors.green,
            ),
          );
        });
      } else {
        throw Exception("Unexpected data format");
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Avoid infinite loading
      });
      // Show Snackbar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator()); // Show loading indicator
    }

    return Center(
      child: List1(
        data: _contacts
            .map((e) => ListItem1Data(
                  title: e.name,
                  icon: Icons.person,
                  onPressed: () {
                    Navigator.pushNamed(context, "/chat_screen", arguments: {
                      'friend_uid': e.uid,
                      'uid': widget.uid,
                      'is_group': false
                    });
                  },
                ))
            .toList(),
        color: CustomColors().blueLighter,
      ),
    );
  }
}
