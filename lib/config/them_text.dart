import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mycloud/config/styles.dart';
import 'package:mycloud/gen/fonts.gen.dart';

class _ThemeText extends StatelessWidget {
  const _ThemeText(
    this.text,
    this.size, {
    super.key,
    required this.color,
    required this.weight,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String? text;
  final Color color;
  final double size;
  final FontWeight weight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final fixPadding = size.toDouble() / 15.0;

    return Padding(
      padding: EdgeInsets.only(
        top: fixPadding.toDouble(),
        bottom: fixPadding.toDouble(),
      ),
      child: Text(
        text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: weight,
          color: color,
          fontSize: size,
          height: 1.5,
          overflow: overflow,
        ),
      ),
    );
  }
}

class BlackText extends _ThemeText {
  const BlackText(
    super.text,
    super.size, {
    super.key,
    super.textAlign,
  }) : super(color: Styles.commonTextColor, weight: FontWeight.w400);

  const BlackText.bold(
    super.text,
    super.size, {
    super.key,
    super.textAlign,
  }) : super(color: Styles.commonTextColor, weight: FontWeight.w700);
}

class WhiteText extends _ThemeText {
  const WhiteText(
    super.text,
    super.size, {
    super.key,
    super.textAlign,
  }) : super(color: Styles.secondaryTextColor, weight: FontWeight.w400);

  const WhiteText.bold(
    super.text,
    super.size, {
    super.key,
    super.textAlign,
  }) : super(color: Styles.secondaryTextColor, weight: FontWeight.w700);
}

class CustomText extends _ThemeText {
  const CustomText(
    super.text,
    super.size, {
    super.key,
    required super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
  }) : super(weight: FontWeight.w400);

  const CustomText.bold(
    super.text,
    super.size, {
    super.key,
    required super.color,
    super.overflow,
    super.maxLines,
    super.textAlign,
  }) : super(weight: FontWeight.w700);
}
