import 'package:simple_chat/components/buttons/custom_button_1/custom_button.dart';
import 'package:simple_chat/components/dialogues/simple_dialogue.dart';
import 'package:simple_chat/components/text_input/text_input_with_leading_icon.dart';
import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/controllers/textController.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/api/user_api.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late final CredentialController credentialController;
  late final TextStyle textStyleHeading;
  late final TextStyle textStyleTextInputTopic;
  late final TextStyle textStyleInputField;
  String msg = "";

  @override
  void initState() {
    super.initState();
    credentialController = CredentialController();
    textStyleHeading = TextStyle(
        color: CustomColors().blue, fontSize: 30, fontWeight: FontWeight.bold);
    textStyleTextInputTopic = const TextStyle(
        color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);
    textStyleInputField = TextStyle(
        color: CustomColors().blueDark,
        fontSize: 15,
        fontWeight: FontWeight.bold);
    msg = "";
  }

  Future<bool> checkCredentials() async {
    if (credentialController.password != credentialController.confirmPassword) {
      setState(() {
        msg = "Passwords are not matching";
      });
      return false;
    }
    Map<String, dynamic> result = await UserApiService().createUser(
        credentialController.name,
        credentialController.username,
        credentialController.password);

    if (result['status'] == true) {
      setState(() {
        msg = result['data'].toString();
      });
      return true;
    } else {
      setState(() {
        msg = result['error'].toString();
      });
      return false;
    }
  }

  bool checkGoogleCredentials() {
    return false;
  }

  bool checkFacebookCredentials() {
    return true;
  }

  void signUpError() {
    showDialog(
        context: context,
        builder: (context) => DialogFb2(
              text: "Signup Error!",
              subText: msg,
              icon: Icons.error,
              basicColor: Colors.white,
              fontColor: Colors.red,
              subTextFontColor: CustomColors().greyHint,
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              btnText: "Close",
              btnBackColor: CustomColors().blue,
              btnTextColor: Colors.white,
            ));
  }

  void navigateToHome() {
    credentialController.clear();
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Scaffold(
      appBar: MallikaAppBar5(
        title: "Sign up",
        backButton: true,
        backOnPressed: () {
          credentialController.clear();
          Navigator.pop(context);
        },
        titleColor: Colors.white,
        backgroundColor: CustomColors().blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: AppSizes().getScreenHeight(),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: textStyleTextInputTopic,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InputFieldFb3(
                    inputController: credentialController,
                    hint: "Name",
                    icon: Icons.person,
                    hintColor: CustomColors().greyHint,
                    textColor: CustomColors().blueDark,
                    shadowColor: CustomColors().blueLighter,
                    enableBorderColor: CustomColors().blueLight,
                    borderColor: CustomColors().blueDark,
                    focusedBorderColor: CustomColors().blueDark,
                    typeKey: CustomTextInputTypes().name),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "User Name",
                      style: textStyleTextInputTopic,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InputFieldFb3(
                    inputController: credentialController,
                    hint: "User name",
                    icon: Icons.person,
                    hintColor: CustomColors().greyHint,
                    textColor: CustomColors().blueDark,
                    shadowColor: CustomColors().blueLighter,
                    enableBorderColor: CustomColors().blueLight,
                    borderColor: CustomColors().blueDark,
                    focusedBorderColor: CustomColors().blueDark,
                    typeKey: CustomTextInputTypes().username),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("Password", style: textStyleTextInputTopic)],
                ),
                const SizedBox(
                  height: 5,
                ),
                InputFieldFb3(
                    inputController: credentialController,
                    hint: "Password",
                    icon: Icons.key,
                    hintColor: CustomColors().greyHint,
                    textColor: CustomColors().blueDark,
                    shadowColor: CustomColors().blueLighter,
                    enableBorderColor: CustomColors().blueLight,
                    borderColor: CustomColors().blueDark,
                    focusedBorderColor: CustomColors().blueDark,
                    isPassword: true,
                    typeKey: CustomTextInputTypes().password),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Confirm Password", style: textStyleTextInputTopic)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InputFieldFb3(
                    inputController: credentialController,
                    hint: "Confirm Password",
                    icon: Icons.key,
                    hintColor: CustomColors().greyHint,
                    textColor: CustomColors().blueDark,
                    shadowColor: CustomColors().blueLighter,
                    enableBorderColor: CustomColors().blueLight,
                    borderColor: CustomColors().blueDark,
                    focusedBorderColor: CustomColors().blueDark,
                    isPassword: true,
                    typeKey: CustomTextInputTypes().confirmPassword),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                        label: "Sign up",
                        backgroundColor: CustomColors().blue,
                        textColor: Colors.white,
                        icon: Icons.create,
                        onPressed: () async {
                          if (await checkCredentials()) {
                            navigateToHome();
                          } else {
                            signUpError();
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
