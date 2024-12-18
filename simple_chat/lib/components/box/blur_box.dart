import 'dart:ui';
import 'package:flutter/material.dart';

class BluredBox extends StatelessWidget {
  final double width;
  final double height;
  final double paddingHorizontal;
  final double paddingVertical;
  final Widget child;
  final double borderRadius;
  final double opacity;
  final double sigmaX;
  final double sigmaY;
  const BluredBox({
    super.key,
    required this.width,
    required this.height,
    required this.paddingHorizontal,
    required this.paddingVertical,
    required this.child,
    this.borderRadius = 0.3,
    this.opacity = 0.3,
    this.sigmaX = 10.0,
    this.sigmaY = 10.0,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal, vertical: paddingVertical),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [child],
            )),
      ),
    );
  }
}
