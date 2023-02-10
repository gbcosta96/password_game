
import 'package:flutter/material.dart';

import '../const.dart';

class AppText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final bool bold;

  const AppText(this.text, { Key? key,
    this.color,
    this.size = 20,
    this.bold = false
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.letterColor,
        fontFamily: 'Roboto',
        fontWeight: bold ? FontWeight.bold : FontWeight.w500,
        fontSize: size,
      ),
    );
  }
}