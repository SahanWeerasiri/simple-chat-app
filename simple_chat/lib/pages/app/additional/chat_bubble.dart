import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel chatModel;
  const ChatBubble({super.key, required this.chatModel});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: AppSizes().getScreenWidth() / 3 * 2,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: chatModel.isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: chatModel.isSender
                          ? CustomColors().blueLight
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.5))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: chatModel.isSender
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              chatModel.name,
                              style: TextStyle(
                                  color: chatModel.isSender
                                      ? Colors.white
                                      : CustomColors().blueLight,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                                width: AppSizes().getBlockSizeHorizontal(45),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: chatModel.isSender
                                      ? CustomColors().blueLighter
                                      : CustomColors().blueLighter,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: chatModel.isSender
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        chatModel.msg,
                                        style: TextStyle(
                                            color: chatModel.isSender
                                                ? CustomColors().blueDark
                                                : Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: AppSizes()
                                                .getBlockSizeHorizontal(5)),
                                      ),
                                    ],
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  chatModel.timestamp.split("T").last,
                                  style: TextStyle(
                                    color: chatModel.isSender
                                        ? Colors.white
                                        : CustomColors().blueDark,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            )
          ],
        ));
  }
}

class ChatModel {
  final String msg;
  final String timestamp;
  final bool isSender;
  final String name;
  ChatModel(this.msg, this.timestamp, this.isSender, this.name);
}
