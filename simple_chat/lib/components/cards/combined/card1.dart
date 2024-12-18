import 'package:flutter/material.dart';
import '../../buttons/custom_button_1/custom_button.dart'; // Import the CustomButton
import '../../dialogues/alert_dialogue.dart'; // Import the CustomAlertDialog

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;
  final double elevation;
  final Color? backgroundColor;
  final bool isImageNetwork;
  final double borderRadius;
  final double width;
  final double height;
  final VoidCallback? onLongPress;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? childButtonBackgroundColor;
  final Color? childButtonTextColor;
  final VoidCallback? childButtonOnPressed;

  const CustomCard({
    super.key,
    this.title = 'Card Title',
    this.subtitle = 'Card Subtitle',
    this.imageUrl = 'assets/images/test.jpg',
    this.isImageNetwork = false,
    this.onTap,
    this.onLongPress,
    this.elevation = 20,
    this.backgroundColor = Colors.white,
    this.borderRadius = 10,
    this.width = 300,
    this.height = 200,
    this.titleColor,
    this.subtitleColor,
    this.childButtonBackgroundColor,
    this.childButtonTextColor,
    this.childButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              child: isImageNetwork
                  ? Image.network(
                      imageUrl,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imageUrl,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: titleColor ?? Colors.black,
                        ),
                  ),
                  SizedBox(height: height * 0.02),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: subtitleColor ?? Colors.grey[600],
                        ),
                  ),
                  SizedBox(
                    width: width - width * 0.1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        backgroundColor:
                            childButtonBackgroundColor ?? Colors.blue,
                        textColor: childButtonTextColor ?? Colors.white,
                        icon: Icons.edit,
                        isLoading: false,
                        shape: CustomButton.shapeSquare,
                        borderRadius: 10,
                        elevation: 20,
                        cornerRadius: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.05,
                        label: 'Click Me',
                        onPressed: () => childButtonOnPressed != null
                            ? childButtonOnPressed!()
                            : CustomAlertDialog.showSimpleAlert(
                                context,
                                'Default Button Pressed!',
                                'Default Button Pressed!',
                                Colors.blue,
                                Colors.white,
                                Colors.white,
                                Icons.thumb_up,
                                'OK',
                                Colors.white,
                                false,
                                Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
