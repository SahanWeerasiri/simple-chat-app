import 'package:simple_chat/components/buttons/custom_button_1/custom_button.dart';
import 'package:simple_chat/components/dialogues/simple_dialogue.dart';
import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/components/text/text1/custom_text1.dart';
import 'package:simple_chat/components/text_input/text_input_with_leading_icon.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/api/status_api.dart';
import 'package:simple_chat/controllers/textController.dart';

class Status extends StatefulWidget {
  final int uid;
  const Status({super.key, required this.uid});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  late List<StatusDetails> _statusDetails;
  late List<StatusDetails> _myStatusDetails;
  final CredentialController credentialController = CredentialController();
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _fetchStatus();
    _fetchMyStatus();
  }

  void _fetchStatus() async {
    try {
      Map<String, dynamic> map = await StatusApiService().getStatus(widget.uid);
      if (map['status']) {
        List<StatusDetails> status = (map['data'] as List).map((element) {
          return StatusDetails(
            statusId: element['status_id'],
            name: element['u_name'],
            messege: element['messege'],
          );
        }).toList();
        setState(() {
          _statusDetails = status;
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

  void _fetchMyStatus() async {
    try {
      Map<String, dynamic> map2 =
          await StatusApiService().getMyStatus(widget.uid);
      if (map2['status']) {
        List<StatusDetails> status2 = (map2['data'] as List).map((element) {
          return StatusDetails(
            statusId: element['status_id'],
            name: "Me",
            messege: element['messege'],
          );
        }).toList();
        setState(() {
          _myStatusDetails = status2;
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

  void onRemove(statusId) async {
    Map<String, dynamic> res =
        await StatusApiService().deleteStatus(widget.uid, statusId);
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

  void onAdd() async {
    Map<String, dynamic> res = await StatusApiService()
        .addStatus(widget.uid, credentialController.text);
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
        body: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 5,
        children: [
          const SizedBox(
            height: 5,
          ),
          InputFieldFb3(
              inputController: credentialController,
              hint: "Status",
              icon: Icons.star,
              typeKey: CustomTextInputTypes().text),
          CustomButton(
              label: "Add Status",
              backgroundColor: CustomColors().blue,
              textColor: Colors.white,
              icon: Icons.add_comment,
              onPressed: () {
                onAdd();
              }),
          const Divider(
            height: 2,
          ),
          const CustomText1(text: "My Status"),
          Expanded(
            child: List1(
              data: _myStatusDetails
                  .map(
                    (status) => ListItem1Data(
                      title: '${status.name}\n${status.messege}',
                      icon: Icons.star,
                      icon2: Icons.delete,
                      onPressed: () {
                        onRemove(status.statusId);
                      },
                    ),
                  )
                  .toList(),
              color: CustomColors().blueLighter,
            ),
          ),
          const Divider(
            height: 2,
          ),
          const CustomText1(text: "Status"),
          Expanded(
            child: List1(
              data: _statusDetails
                  .map((status) => ListItem1Data(
                      title: status.name,
                      icon: Icons.star,
                      onPressed: () {
                        _showDialogue(status.messege, status.name);
                      }))
                  .toList(),
              color: CustomColors().blueLighter,
            ),
          ),
        ],
      ),
    ));
  }
}
