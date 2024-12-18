import 'package:flutter/material.dart';
import '../../components/text/text1/custom_text1.dart';

class TestText1 extends StatelessWidget {
  const TestText1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText1(
              text: 'Test Text 1',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: Colors.blue,
            ),
            const SizedBox(height: 16),
            const CustomText1(
              text: 'Test Text 2',
              fontSize: 18,
              fontWeight: FontWeight.w300,
              textColor: Colors.red,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            const CustomText1(
              text: 'Test Text 3',
              fontSize: 20,
              textColor: Colors.green,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            const CustomText1(
              text: 'Test Text 4',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textColor: Colors.purple,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const CustomText1(
              text: 'Test Text 5',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              textColor: Colors.orange,
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 16),
            const CustomText1(
              text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              textColor: Colors.deepPurple,
              style: TextStyle(
                letterSpacing: 1.2,
                height: 1.5,
                shadows: [
                  Shadow(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    offset: Offset(2, 2),
                    blurRadius: 3,
                  )
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            CustomText1(
              text: 'Vivamus sagittis lacus vel augue laoreet!',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              textColor: Colors.teal,
              style: TextStyle(
                background: Paint()
                  ..color = Colors.yellow.withOpacity(0.3)
                  ..style = PaintingStyle.fill,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomText1(
              text: '✨ Special Effects Text ✨',
              fontSize: 26,
              fontWeight: FontWeight.w700,
              textColor: Colors.pink,
              style: TextStyle(
                decoration: TextDecoration.combine(
                    [TextDecoration.overline, TextDecoration.underline]),
                decorationColor: Colors.amber,
                decorationStyle: TextDecorationStyle.wavy,
                decorationThickness: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
