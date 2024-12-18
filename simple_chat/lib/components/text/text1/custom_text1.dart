import 'package:flutter/material.dart';

class CustomText1 extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;

  const CustomText1({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.fontSize,
    this.fontWeight,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ) ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.clip,
      maxLines: maxLines,
    );
  }
}
