import 'package:flutter/material.dart';
import '../../components/text_input/text_input_with_leading_icon.dart';
import '../../controllers/textController.dart';
import '../../constants/consts.dart';

class TestTextInput1 extends StatelessWidget {
  const TestTextInput1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Text Input 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InputFieldFb3(
          inputController: CredentialController(),
          hint: 'Text',
          icon: Icons.text_fields,
          typeKey: CustomTextInputTypes().text,
        ),
      ),
    );
  }
}
