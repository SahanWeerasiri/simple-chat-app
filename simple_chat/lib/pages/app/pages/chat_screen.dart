import 'package:simple_chat/components/text_input/text_input_with_send.dart';
import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/controllers/textController.dart';
import 'package:simple_chat/pages/app/additional/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final List<ChatBubble> _chatBubbles;
  @override
  void initState() {
    super.initState();
    _chatBubbles = [];
  }

  final CredentialController credentialController = CredentialController();

  void onSend() {
    String d =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}_${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
    setState(() {
      _chatBubbles.add(ChatBubble(
          chatModel: ChatModel(credentialController.text, d, true, "Me")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MallikaAppBar5(
        automaticLeading: true,
        title: "Chat App - Chat Screen",
        backButton: false,
        backgroundColor: CustomColors().blue,
        titleColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _chatBubbles.length,
                itemBuilder: (context, index) {
                  return _chatBubbles[index];
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextInputWithSend(
                    inputController: credentialController,
                    hint: "Message",
                    icon: Icons.message,
                    typeKey: CustomTextInputTypes().text,
                    onSend: onSend)),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
