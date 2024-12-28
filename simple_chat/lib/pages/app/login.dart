import 'package:simple_chat/components/buttons/custom_button_1/custom_button.dart';
import 'package:simple_chat/components/dialogues/simple_dialogue.dart';
import 'package:simple_chat/components/text_input/text_input_with_leading_icon.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/controllers/textController.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/api/user_api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final CredentialController credentialController;
  late final TextStyle textStyleHeading;
  late final TextStyle textStyleTextInputTopic;
  late final TextStyle textStyleInputField;
  String msg = "";
  int uid = 0;

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
    uid = 0;
  }

  Future<bool> checkCredentials() async {
    Map<String, dynamic> result = await UserApiService()
        .signIn(credentialController.username, credentialController.password);

    if (result['status'] == true) {
      setState(() {
        uid = int.fromEnvironment(result['data'].toString());
      });
      return true;
    } else {
      setState(() {
        msg = result['error'].toString();
      });
      return false;
    }
  }

  void navigateToSignUp() {
    credentialController.clear();
    Navigator.pushNamed(context, '/signup');
  }

  void loginError() {
    showDialog(
        context: context,
        builder: (context) => DialogFb2(
              text: "Login Error!",
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
    Navigator.pushNamed(context, '/home', arguments: {'uid': uid});
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Container(
          height: AppSizes().getScreenHeight(),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome !",
                  style: textStyleHeading,
                ),
                SizedBox(
                  height: AppSizes.screenHeight / 5,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      label: "Sign In",
                      onPressed: () async {
                        if (await checkCredentials()) {
                          navigateToHome();
                        } else {
                          loginError();
                        }
                      },
                      backgroundColor: CustomColors().blue,
                      textColor: Colors.white,
                      icon: Icons.login,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: CustomColors().greyHint,
                  endIndent: 5,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Don't you have an account?"),
                CustomButton(
                    label: "Sign up",
                    backgroundColor: CustomColors().blue,
                    textColor: Colors.white,
                    icon: Icons.create,
                    onPressed: () {
                      navigateToSignUp();
                    }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
