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
  final List<ChatBubble> _chatBubbles = [];
  final CredentialController credentialController = CredentialController();

  void onSend() {
    setState(() {
      _chatBubbles.add(ChatBubble(
          chatModel: ChatModel(credentialController.text,
              DateTime.now().toIso8601String(), true, "Me")));
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
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: _chatBubbles,
                ),
              ), // Space for chat messages
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
