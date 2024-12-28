import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/api/group_api.dart';

class Groups extends StatefulWidget {
  final int uid;

  const Groups({super.key, required this.uid});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  late List<ContactDetails> _groups = [];
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchContacts(); // Call a separate method without `await`
  }

  void _fetchContacts() async {
    try {
      Map<String, dynamic> map = await GroupApiService().getGroups(widget.uid);
      if (map['status']) {
        List<ContactDetails> groups = (map['data'] as List).map((element) {
          return ContactDetails(
            uid: element['group_id'],
            name: element['group_name'],
            img: "",
          );
        }).toList();
        setState(() {
          _groups = groups; // Update the state with fetched contacts
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
        data: _groups
            .map((e) => ListItem1Data(
                  title: e.name,
                  icon: Icons.group,
                  onPressed: () {
                    Navigator.pushNamed(context, "/chat_screen", arguments: {
                      'group_id': e.uid,
                      'uid': widget.uid,
                      'is_group': true
                    });
                  },
                ))
            .toList(),
        color: CustomColors().blueLighter,
      ),
    );
  }
}
