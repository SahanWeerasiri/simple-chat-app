import 'package:flutter/material.dart';
import 'package:simple_chat/components/buttons/custom_button_1/custom_button.dart';
import 'package:simple_chat/components/dialogues/simple_dialogue.dart';
import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/components/text/text1/custom_text1.dart';
import 'package:simple_chat/components/text_input/text_input_with_leading_icon.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/api/contacts_api.dart';
import 'package:simple_chat/controllers/textController.dart';
import 'package:simple_chat/api/user_api.dart';

class Profile extends StatefulWidget {
  final int uid;

  const Profile({super.key, required this.uid});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<Request> _requests;
  late List<Request> _myRequests;
  late MyProfile me;
  late final CredentialController credentialController = CredentialController();
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchRequests();
    _fetchMyRequests();
    _getProfile();
  }

  void _fetchRequests() async {
    try {
      Map<String, dynamic> map =
          await ContactApiService().showTheirRequests(widget.uid);
      if (map['status']) {
        List<Request> requests = (map['data'] as List).map((element) {
          return Request(
              requestId: element['request_id'],
              name: element['u_name'],
              img: element['img'],
              state: element['state'],
              timestamp: element['time_stamp']);
        }).toList();
        setState(() {
          _requests = requests;
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

  void _fetchMyRequests() async {
    try {
      Map<String, dynamic> map2 =
          await ContactApiService().showMyRequests(widget.uid);
      if (map2['status']) {
        List<Request> myRequests = (map2['data'] as List).map((element) {
          return Request(
              requestId: element['request_id'],
              name: element['u_name'],
              img: element['img'],
              state: element['state'],
              timestamp: element['time_stamp']);
        }).toList();
        setState(() {
          _myRequests = myRequests;
          _isLoading = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(map2['messege']),
              backgroundColor: Colors.green,
            ),
          );
        });
      } else {
        throw Exception(map2['error']);
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

  void _getProfile() async {
    try {
      Map<String, dynamic> map2 = await UserApiService().getProfile(widget.uid);
      if (map2['status']) {
        List<MyProfile> myProfile = (map2['data'] as List).map((element) {
          return MyProfile(uid: widget.uid, name: element['u_name']);
        }).toList();

        setState(() {
          me = myProfile[0];
          credentialController.name = me.name;
          _isLoading = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(map2['messege']),
              backgroundColor: Colors.green,
            ),
          );
        });
      } else {
        throw Exception(map2['error']);
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

  void onResponse(senderId, response) async {
    Map<String, dynamic> res = await ContactApiService()
        .responseRequest(widget.uid, senderId, response);
    if (res['status']) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['messege']),
            backgroundColor: Colors.green,
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

  void onUpdate() async {
    Map<String, dynamic> res = await UserApiService()
        .updateProfile(widget.uid, credentialController.name, "");
    if (res['status']) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['messege']),
            backgroundColor: Colors.green,
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

  void _showDialogue(String msg, String name) {
    showDialog(
        context: context,
        builder: (context) => DialogFb2(
              text: name,
              subText: msg,
              icon: Icons.add_reaction,
              basicColor: Colors.white,
              fontColor: Colors.black,
              subTextFontColor: CustomColors().blue,
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              btnText: "Close",
              btnBackColor: CustomColors().blue,
              btnTextColor: Colors.white,
            ));
  }

  Color _getBackColor(String status) {
    if (status == "Pending") {
      return CustomColors().blueLighter;
    } else if (status == "Accepted") {
      return Colors.greenAccent;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator()); // Show loading indicator
    }
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.all(5),
              child: InputFieldFb3(
                  inputController: credentialController,
                  hint: "Name",
                  icon: Icons.person,
                  typeKey: CustomTextInputTypes().name),
            ),
            CustomButton(
                label: "Update",
                backgroundColor: CustomColors().blue,
                textColor: Colors.white,
                icon: Icons.update,
                onPressed: () {
                  onUpdate();
                }),
            const SizedBox(
              height: 2,
            ),
            const Divider(
              height: 2,
            ),
            const CustomText1(text: "My Requests"),
            Expanded(
              child: List1(
                data: _myRequests
                    .map(
                      (status) => ListItem1Data(
                        title: '${status.name}\n${status.state}',
                        icon: Icons.star,
                        icon2: Icons.arrow_forward,
                        onPressed: () {},
                      ),
                    )
                    .toList(),
                color: CustomColors().blueLighter,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            const Divider(
              height: 2,
            ),
            const CustomText1(text: "Requsts From others"),
            Expanded(
              child: List1(
                data: _requests
                    .map((status) => ListItem1Data(
                        title: '${status.name}\n${status.state}',
                        icon: Icons.star,
                        onPressed: () {
                          _showDialogue(status.name,
                              '${status.state}\n${status.timestamp}');
                        },
                        color: _getBackColor(status.state)))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
