import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextDirection? textDirection;

  const TextWidget({
    Key? key,
    required this.text,
    this.maxLines,
    this.color,
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 16,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w300,
      ),
      textDirection: textDirection ?? TextDirection.ltr,
    );
  }
}
