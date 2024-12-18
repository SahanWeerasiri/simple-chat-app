import 'package:flutter/material.dart';
import '../../components/cards/combined/card1.dart';
import '../../constants/consts.dart';

class TestCard1 extends StatelessWidget {
  const TestCard1({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Card 1'),
      ),
      body: SizedBox(
        width: AppSizes().getScreenWidth(),
        height: AppSizes().getScreenHeight(),
        child: Column(
          children: [
            CustomCard(
              title: 'Test Card 1',
              subtitle: 'Test Card 1',
              imageUrl: 'https://via.placeholder.com/100',
              isImageNetwork: true,
              onTap: () => {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Test Card 1 tapped'),
                  ),
                ),
              },
              onLongPress: () => {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Test Card 1 long pressed'),
                  ),
                ),
              },
              elevation: 8,
              backgroundColor: Colors.blue,
              width: AppSizes().getBlockSizeHorizontal(50),
              height: AppSizes().getBlockSizeHorizontal(50),
              childButtonOnPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Child button pressed'),
                  ),
                ),
              },
              borderRadius: 16,
              subtitleColor: Colors.white,
              titleColor: Colors.white,
              childButtonBackgroundColor: Colors.red,
              childButtonTextColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
