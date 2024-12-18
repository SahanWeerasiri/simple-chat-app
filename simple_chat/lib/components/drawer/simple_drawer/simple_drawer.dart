import 'package:flutter/material.dart';
import '../../../components/list/design1/list_item1.dart';
import '../../../constants/consts.dart';
import 'drawer_index_controller.dart';

class DrawerFb1 extends StatefulWidget {
  final String title;
  final List<DrawerItems> items;
  final Color backgroundColor;
  final Color textColor;
  final Color selectedTextColor;
  final Color dividerColor;
  final double drawerWidth;
  final double drawerRadius;
  final DrawerIndexController drawerIndexController;
  const DrawerFb1(
      {super.key,
      required this.title,
      required this.items,
      required this.backgroundColor,
      required this.textColor,
      required this.selectedTextColor,
      required this.dividerColor,
      required this.drawerWidth,
      required this.drawerRadius,
      required this.drawerIndexController});

  @override
  State<DrawerFb1> createState() => _DrawerFb1State();
}

class _DrawerFb1State extends State<DrawerFb1> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: widget.drawerWidth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.drawerRadius),
      ),
      child: Material(
        color: widget.backgroundColor,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: widget.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...widget.items.map((item) => Column(
                        children: [
                          item.title != ''
                              ? MenuItem(
                                  text: item.title,
                                  icon: item.icon,
                                  isSelected: item.index ==
                                      widget.drawerIndexController
                                          .getSelectedIndex(),
                                  onClicked: () =>
                                      selectedItem(context, item.index),
                                  textColor: widget.textColor,
                                  selectedTextColor: widget.selectedTextColor,
                                )
                              : Divider(color: widget.dividerColor),
                          const SizedBox(height: 5),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    widget.drawerIndexController.setSelectedIndex(index);
    Navigator.of(context).pop();
    if (index < widget.items.length) {
      widget.items[index].onTap();
    }
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onClicked;
  final bool isSelected;
  final Color textColor;
  final Color selectedTextColor;
  const MenuItem({
    required this.text,
    required this.icon,
    this.onClicked,
    required this.isSelected,
    required this.textColor,
    required this.selectedTextColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ListItem1(
            color: textColor,
            textColor: selectedTextColor,
            title: text,
            icon: icon,
            onPressed: onClicked ?? () {},
            shadowBlurRadius: 20,
            needArrow: false,
          )
        : ListItem1(
            color: selectedTextColor,
            textColor: textColor,
            title: text,
            icon: icon,
            onPressed: onClicked ?? () {},
            shadowBlurRadius: 20,
            needArrow: false,
          );
  }
}
