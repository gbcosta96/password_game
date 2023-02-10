import 'package:flutter/material.dart';

import '../const.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double width;
  
  const AppButton({ Key? key, this.onTap, this.width = 150, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        color: AppColors.mainColor,
        child: Center(child:  AppText(text)),
      ),
    );
  }
}