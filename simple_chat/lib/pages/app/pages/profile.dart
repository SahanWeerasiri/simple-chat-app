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
import 'package:simple_chat/pages/app/additional/simple_dialogue_response.dart';

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
  String name = "";
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
              senderId: element['sender_id'],
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
          return MyProfile(
              uid: widget.uid, name: element['u_name'], img: element['img']);
        }).toList();

        setState(() {
          me = myProfile[0];
          credentialController.name = me.name;
          name = me.name;
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
    String imgUp = me.img;
    String nameUp = me.name;
    if (credentialController.name != "") {
      nameUp = credentialController.name;
    }

    Map<String, dynamic> res =
        await UserApiService().updateProfile(widget.uid, nameUp, imgUp);
    if (res['status']) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['messege']),
            backgroundColor: Colors.green,
          ),
        );
      });
      setState(() {
        credentialController.name = "";
        _getProfile();
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

  void refresh() {
    setState(() {
      _fetchRequests();
      _fetchMyRequests();
      _getProfile();
    });
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

  void _showDialogueResponse(String msg, String name, int senderId) {
    showDialog(
        context: context,
        builder: (context) => DialogResponse(
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
              onPressedAccepted: () {
                onResponse(senderId, "Accepted");
                Navigator.pop(context);
                setState(() {
                  _fetchRequests();
                });
              },
              onPressedRejected: () {
                onResponse(senderId, "Rejected");
                Navigator.pop(context);
                setState(() {
                  _fetchRequests();
                });
              },
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
    AppSizes().initSizes(context);
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: CustomColors().blue,
      ));
    }
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 5,
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: CustomColors().blueLighter,
                          child: const Icon(Icons.person),
                        ),
                        Text(name)
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: AppSizes().getBlockSizeHorizontal(50),
                          height: AppSizes().getBlockSizeHorizontal(10),
                          child: InputFieldFb3(
                              inputController: credentialController,
                              hint: "Name",
                              icon: Icons.abc,
                              typeKey: CustomTextInputTypes().name),
                        ),
                        CustomButton(
                            label: "Update",
                            backgroundColor: CustomColors().blue,
                            textColor: Colors.white,
                            icon: Icons.update,
                            onPressed: () async {
                              onUpdate();
                            }),
                      ],
                    )
                  ],
                )),
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
                          onPressed: () {
                            _showDialogue(status.name,
                                '${status.state}\n${status.timestamp}');
                          },
                          color: _getBackColor(status.state)),
                    )
                    .toList(),
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
                          _showDialogueResponse(
                              status.name,
                              '${status.state}\n${status.timestamp}',
                              status.senderId);
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
