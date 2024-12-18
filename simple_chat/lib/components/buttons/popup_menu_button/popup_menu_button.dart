import 'package:flutter/material.dart';
import './types.dart';

class PopupMenuCustomButton extends StatelessWidget {
  final List<MenuItems> menuItemList;
  final String shape;
  final Color color;
  final String label;
  final IconData icon;

  const PopupMenuCustomButton({
    super.key,
    required this.menuItemList,
    required this.shape,
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // return MenuAnchor(
    //   builder: (context, controller, child) {
    //     return InkWell(
    //       onTap: () {
    //         if (controller.isOpen) {
    //           controller.close();
    //         } else {
    //           controller.open();
    //         }
    //       },
    //       child: Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //         decoration: BoxDecoration(
    //           color: color.withOpacity(0.1),
    //           borderRadius: BorderRadius.circular(8),
    //         ),
    //         child: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Icon(icon, color: color, size: 20),
    //             const SizedBox(width: 8),
    //             Text(
    //               label,
    //               style: TextStyle(color: color),
    //             ),
    //             const SizedBox(width: 4),
    //             Icon(
    //               Icons.arrow_drop_down,
    //               color: color,
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    //   menuChildren: menuItemList
    //       .map(
    //         (item) => MenuItemButton(
    //           onPressed: item.onClick,
    //           child: Row(
    //             children: [
    //               Icon(item.icon, color: color, size: 20),
    //               const SizedBox(width: 8),
    //               Text(
    //                 item.label,
    //                 style: TextStyle(color: color),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //       .toList(),
    //   style: MenuStyle(
    //     shape: MaterialStateProperty.all(shape == 'rounded'
    //         ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
    //         : RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    //   ),
    // );
    return ElevatedButton(
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.3),
        maximumSize: const Size(100, 40),
        alignment: Alignment.center,
        shape: shape == 'rounded'
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
      ),
      child: Row(
        children: [Icon(icon), Text(label)],
      ),
    );
  }
}
