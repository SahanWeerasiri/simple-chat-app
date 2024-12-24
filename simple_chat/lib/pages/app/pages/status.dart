import 'package:simple_chat/components/list/design1/list1.dart';
import 'package:simple_chat/components/list/design1/list_item_data.dart';
import 'package:simple_chat/constants/consts.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  final List<StatusModel> _statuses = [
    StatusModel("Status 1", Icons.person),
    StatusModel("Status 2", Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: List1(
          data: _statuses
              .map((status) => ListItem1Data(
                  title: status.name, icon: status.icon, onPressed: () {}))
              .toList(),
          color: CustomColors().blueLighter,
        ),
      ),
    );
  }
}

class StatusModel {
  final String name;
  final IconData icon;
  StatusModel(this.name, this.icon);
}
