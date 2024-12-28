import 'package:simple_chat/components/buttons/custom_button_1/custom_button.dart';
import 'package:simple_chat/components/text_input/text_input_with_leading_icon.dart';
import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/controllers/textController.dart';
import 'package:simple_chat/api/group_api.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final CredentialController credentialController = CredentialController();
  late int uid;
  bool done = false;

  @override
  void initState() {
    super.initState();
    done = false;
  }

  void _getUID() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    setState(() {
      uid = arguments['uid'];
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUID();
  }

  Future<void> _createGroup() async {
    try {
      Map<String, dynamic> map =
          await GroupApiService().createGroup(uid, credentialController.name);
      if (map['status']) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(map['messege']),
              backgroundColor: Colors.green,
            ),
          );
        });
        setState(() {
          done = true;
        });
      } else {
        throw Exception(map['error']);
      }
    } catch (e) {
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
    if (done) {
      Navigator.pop(context);
    }
    return Scaffold(
        appBar: MallikaAppBar5(
          automaticLeading: true,
          title: "Chat App - Add Group",
          backButton: false,
          backgroundColor: CustomColors().blue,
          titleColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
              child: Column(
            children: [
              const SizedBox(height: 20),
              InputFieldFb3(
                  inputController: credentialController,
                  hint: "Group Name",
                  icon: Icons.group,
                  hintColor: CustomColors().greyHint,
                  textColor: CustomColors().blueDark,
                  shadowColor: CustomColors().blueLighter,
                  enableBorderColor: CustomColors().blueLight,
                  borderColor: CustomColors().blueDark,
                  focusedBorderColor: CustomColors().blueDark,
                  typeKey: CustomTextInputTypes().name),
              const SizedBox(height: 20),
              CustomButton(
                  label: "Create",
                  backgroundColor: CustomColors().blue,
                  textColor: Colors.white,
                  icon: Icons.create,
                  onPressed: () {
                    _createGroup();
                  }),
            ],
          )),
        ));
  }
}
