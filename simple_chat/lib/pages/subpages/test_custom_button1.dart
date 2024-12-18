import 'package:flutter/material.dart';
import '../../../components/buttons/custom_button_1/custom_button.dart';
import '../../../constants/consts.dart';

class TestCustomButton1 extends StatelessWidget {
  const TestCustomButton1({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes appSizes = AppSizes();
    appSizes.initSizes(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Custom Buttons 1"),
      ),
      body: SizedBox(
        width: appSizes.getScreenWidth(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                label: "Default Button",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Default Button'),
                        content: const Text('You pressed the default button!'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Colors.blue,
                icon: Icons.touch_app,
                textColor: Colors.white,
                isLoading: false),
            CustomButton(
                label: "Rounded Button",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(title: Text('Rounded Button'));
                    },
                  );
                },
                backgroundColor: Colors.green,
                shape: CustomButton.shapeRounded,
                borderRadius: 25,
                icon: Icons.check_circle,
                textColor: Colors.white,
                elevation: 5),
            CustomButton(
                label: "Square Button",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(title: Text('Square Button'));
                    },
                  );
                },
                backgroundColor: Colors.red,
                shape: CustomButton.shapeSquare,
                cornerRadius: 0,
                icon: Icons.stop,
                textColor: Colors.white,
                elevation: 8),
            CustomButton(
                label: "Loading Button",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(title: Text('Loading Button'));
                    },
                  );
                },
                backgroundColor: Colors.purple,
                borderRadius: 15,
                icon: Icons.refresh,
                textColor: Colors.white,
                isLoading: true),
            CustomButton(
                label: "Custom Button",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(title: Text('Custom Button'));
                    },
                  );
                },
                backgroundColor: Colors.orange,
                borderRadius: 10,
                width: 250,
                height: 60,
                icon: Icons.star,
                textColor: Colors.black,
                elevation: 4)
          ],
        ),
      ),
    );
  }
}
