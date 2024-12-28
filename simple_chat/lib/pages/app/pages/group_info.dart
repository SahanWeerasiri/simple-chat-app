import 'package:flutter/material.dart';
import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/api/group_api.dart';

class GroupInfo extends StatefulWidget {
  const GroupInfo({super.key});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  late int groupId;
  late String groupName;
  late String groupImg;
  late int uid;
  bool _isLoading = true;
  late List<ContactDetails> _members;

  @override
  void initState() {
    super.initState();
  }

  void _getUID() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      groupId = arguments['group_id'];
      uid = arguments['uid'];
      groupName = arguments['group_name'];
      groupImg = arguments['group_img'];
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUID();
    setState(() {
      _fetchMembers(); // Call a separate method without `await`
    });
  }

  void _fetchMembers() async {
    try {
      Map<String, dynamic> res =
          await GroupApiService().getGroupMembers(uid, groupId);
      if (res['status']) {
        List<ContactDetails> members = (res['data'] as List).map((element) {
          return ContactDetails(
            uid: element['uid'],
            name: element['u_name'],
            img: element['img'] ?? '',
          );
        }).toList();
        setState(() {
          _members = members; // Update the state with fetched contacts
          _isLoading = false; // Set loading to false
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res['messege']),
              backgroundColor: Colors.green,
            ),
          );
        });
      } else {
        throw Exception(res['error']);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  void onRemove(int foeId) async {
    Map<String, dynamic> res =
        await GroupApiService().removeMembers(uid, foeId, groupId);
    if (res['status']) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['messege']),
            backgroundColor: Colors.red,
          ),
        );
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['error']),
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
        title: "Chat App - Group Info",
        backButton: false,
        automaticLeading: true,
        backgroundColor: CustomColors().blue,
        titleColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 10,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: CustomColors().blueLighter,
                child: const Icon(Icons.person),
              ),
            ),
            Container(
              width: AppSizes().getBlockSizeHorizontal(90),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors().blueLighter,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(groupName),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: List1(
              data: _members
                  .map((contact) => ListItem1Data(
                      title: contact.name,
                      icon: Icons.person,
                      onPressed: () {
                        onRemove(contact.uid);
                      },
                      icon2: Icons.delete))
                  .toList(),
              color: CustomColors().blueLighter,
            ))
          ],
        ),
      ),
    );
  }
}
