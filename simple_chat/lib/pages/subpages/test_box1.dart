import 'package:flutter/material.dart';
import '../../components/box/blur_box.dart';

class TestBox1 extends StatelessWidget {
  const TestBox1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Box 1'),
      ),
      body: Container(
        color: Colors.amber,
        child: const Center(
          child: BluredBox(
            width: 300,
            height: 300,
            paddingHorizontal: 10,
            paddingVertical: 10,
            child: Text('Test Box 1'),
          ),
        ),
      ),
    );
  }
}
