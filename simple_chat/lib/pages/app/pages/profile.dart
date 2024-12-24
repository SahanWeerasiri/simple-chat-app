import 'package:flutter/material.dart';
import 'package:simple_chat/constants/consts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 10,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: CustomColors().blueLighter,
                child: const Icon(Icons.person),
              ),
            ),
            Container(
              width: AppSizes().getBlockSizeHorizontal(90),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors().blueLighter,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("Name"),
            ),
            Container(
              width: AppSizes().getBlockSizeHorizontal(90),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors().blueLighter,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("Email"),
            ),
            Container(
              width: AppSizes().getBlockSizeHorizontal(90),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors().blueLighter,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("Phone"),
            ),
            Container(
              width: AppSizes().getBlockSizeHorizontal(90),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColors().blueLighter,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text("Update Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
