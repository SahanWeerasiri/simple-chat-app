import 'package:flutter/material.dart';

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
  final Widget? child;
  final Alignment? childAlignment;

  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.isImageNetwork,
    this.onTap,
    this.onLongPress,
    this.elevation = 4.0,
    this.backgroundColor = Colors.white,
    this.borderRadius = 12.0,
    this.width = 300,
    this.height = 200,
    this.titleColor,
    this.subtitleColor,
    this.child,
    this.childAlignment,
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
                    child: childAlignment == Alignment.center
                        ? Center(child: child)
                        : childAlignment == Alignment.bottomLeft
                            ? Align(
                                alignment: Alignment.bottomLeft,
                                child: child,
                              )
                            : Align(
                                alignment: Alignment.bottomRight,
                                child: child,
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
