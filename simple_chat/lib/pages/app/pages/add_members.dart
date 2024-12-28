import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/api/contacts_api.dart';
import 'package:simple_chat/api/group_api.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  late List<ContactDetails> _contacts;
  bool _isLoading = true; // Loading state
  late int uid;
  late int groupId;

  @override
  void initState() {
    super.initState();
  }

  void _getUID() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      uid = arguments['uid'];
      groupId = arguments['group_id'];
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUID();
    setState(() {
      _fetchContacts(); // Call a separate method without `await`
    });
  }

  Future<void> _fetchContacts() async {
    try {
      Map<String, dynamic> map = await ContactApiService().getMyContacts(uid);
      if (map['status']) {
        List<ContactDetails> contacts = (map['data'] as List).map((element) {
          return ContactDetails(
            uid: element['uid'],
            name: element['u_name'],
            img: element['img'] ?? '',
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

  Future<void> _addMember(int friendUid) async {
    try {
      Map<String, dynamic> map =
          await GroupApiService().addGroupMembers(uid, groupId, friendUid);
      if (map['status']) {
        setState(() {
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
        throw Exception(map['error']);
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
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: CustomColors().blue,
      ));
    }
    return Scaffold(
      appBar: MallikaAppBar5(
        automaticLeading: true,
        title: "Chat App - Add Members",
        backButton: false,
        backgroundColor: CustomColors().blue,
        titleColor: Colors.white,
      ),
      body: Center(
        child: List1(
          data: _contacts
              .map((contact) => ListItem1Data(
                  title: contact.name,
                  icon: Icons.person,
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _addMember(contact.uid);
                  },
                  icon2: Icons.add))
              .toList(),
          color: CustomColors().blueLighter,
        ),
      ),
    );
  }
}
