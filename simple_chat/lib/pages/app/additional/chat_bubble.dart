import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel chatModel;
  const ChatBubble({super.key, required this.chatModel});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          chatModel.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: chatModel.isSender
                    ? CustomColors().blueLighter
                    : Colors.white,
              ),
              width: AppSizes().getBlockSizeHorizontal(30),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text(chatModel.name)],
                    ),
                    Divider(
                      height: 1,
                      color: CustomColors().blueDark,
                    ),
                    Text(chatModel.msg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text(chatModel.timestamp.split("T").last)],
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}

class ChatModel {
  final String msg;
  final String timestamp;
  final bool isSender;
  final String name;
  ChatModel(this.msg, this.timestamp, this.isSender, this.name);
}
