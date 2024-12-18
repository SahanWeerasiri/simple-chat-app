import 'package:flutter/material.dart';
import '../../components/loading_indicator/dotted/dotted_loading_indicator.dart';

class TestLoadingIndicator1 extends StatelessWidget {
  const TestLoadingIndicator1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dotted Loading Indicator'),
      ),
      body: const Center(
        child: DottedCircularProgressIndicatorFb(
          currentDotColor: Colors.blue,
          defaultDotColor: Colors.grey,
          numDots: 10,
        ),
      ),
    );
  }
}
