import 'package:simple_chat/components/text_input/text_input_with_send.dart';
import 'package:simple_chat/components/top_app_bar/top_app_bar.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:simple_chat/controllers/textController.dart';
import 'package:simple_chat/pages/app/additional/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat/api/chat_api.dart';
import 'package:simple_chat/api/group_api.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatBubble> _chatBubbles = [];
  late int uid;
  late int friendUid;
  late int groupId;
  late bool isGroup;
  bool _isLoading = true; // Loading state
  final CredentialController credentialController = CredentialController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  void _initializeData() {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments == null) {
      Navigator.pop(context); // Navigate back if no arguments are passed.
      return;
    }

    setState(() {
      uid = arguments['uid'];
      isGroup = arguments['is_group'];
      if (isGroup) {
        groupId = arguments['group_id'];
        friendUid = 0;
      } else {
        friendUid = arguments['friend_uid'];
        groupId = 0;
      }
    });

    if (isGroup) {
      setState(() {
        _fetchGroupChats();
      });
    } else {
      setState(() {
        _fetchChats();
      });
    }
  }

  void _fetchChats() async {
    try {
      Map<String, dynamic> map =
          await ChatApiService().getMesseges(uid, friendUid);

      if (map['status'] == true) {
        final chatBubbles = (map['data'] as List).map((element) {
          final isSender = element['sender_id'] == uid;
          return ChatBubble(
              chatModel: ChatModel(
                  element['messege'],
                  element['time_stamp'],
                  isSender,
                  isSender ? "Me" : element['u_name'],
                  element['sender_id']));
        }).toList();

        setState(() {
          _chatBubbles = chatBubbles;
          _isLoading = false;
        });
      } else {
        throw Exception(map['error']);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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

  void _fetchGroupChats() async {
    try {
      Map<String, dynamic> map =
          await GroupApiService().getGroupMsg(uid, groupId);

      if (map['status'] == true) {
        final chatBubbles = (map['data'] as List).map((element) {
          final isSender = element['sender_id'] == uid;
          return ChatBubble(
              chatModel: ChatModel(
                  element['messege'],
                  element['time_stamp'],
                  isSender,
                  isSender ? "Me" : element['u_name'],
                  element['sender_id']));
        }).toList();

        setState(() {
          _chatBubbles = chatBubbles;
          _isLoading = false;
        });
      } else {
        throw Exception(map['error']);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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

  void onSend() {
    String d =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}_${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
    setState(() {
      _chatBubbles.add(ChatBubble(
          chatModel: ChatModel(credentialController.text, d, true, "Me", uid)));
    });
    if (isGroup) {
      ChatApiService()
          .sendMessege(uid, groupId, credentialController.text, "Group");
    } else {
      ChatApiService()
          .sendMessege(uid, friendUid, credentialController.text, "Single");
    }
  }

  void onRemove() {}

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(color: CustomColors().blue));
    }
    return Scaffold(
      appBar: MallikaAppBar5(
        automaticLeading: true,
        title: "Chat App - Chat Screen",
        backButton: false,
        backgroundColor: CustomColors().blue,
        titleColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () => {onRemove()},
          )
        ],
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
