import 'package:flutter/material.dart';
import '../../components/buttons/custom_button_1/custom_button.dart';
import '../../components/dialogues/action_dialogue.dart';

class TestDialogue1 extends StatelessWidget {
  const TestDialogue1({super.key});

  void showDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const DialogFb1(),
    );
  }

  void showDialogue2(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Test Dialogue 2'),
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('This is a test dialogue'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    label: 'Close',
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Dialogue 1'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Test Dialogue 1'),
            CustomButton(
              label: 'Show Dialogue',
              onPressed: () => showDialogue(context),
            ),
            const SizedBox(height: 10),
            const Text('Test Dialogue 2'),
            CustomButton(
              label: 'Show Dialogue 2',
              onPressed: () => showDialogue2(context),
            ),
          ],
        ),
      ),
    );
  }
}
