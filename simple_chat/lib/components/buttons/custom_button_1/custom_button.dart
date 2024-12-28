import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isLoading;
  final String shape;
  final double borderRadius;
  final double elevation;
  final double cornerRadius;
  final double width;
  final double height;

  static const String shapeRounded = 'rounded';
  static const String shapeSquare = 'square';

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isLoading = false,
    this.shape = shapeRounded,
    this.borderRadius = 30,
    this.elevation = 3,
    this.cornerRadius = 30,
    this.width = 200,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.1, vertical: height * 0.1),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        elevation: elevation,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: shape == shapeRounded
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: textColor,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(label),
              ],
            ),
    );
  }
}
