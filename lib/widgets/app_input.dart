import 'package:flutter/material.dart';

import '../const.dart';
import '../dimensions.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String? hintText;
  final IconData? prefixIcon;
  const AppInput({Key? key, this.controller, this.isPassword = false, this.hintText, this.prefixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: TextField(
        controller: controller,
        maxLength: 12,
        obscureText: isPassword,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.backColor,
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.inputHint,
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(prefixIcon),
          prefixIconConstraints: BoxConstraints(
            minWidth: Dimensions.width(10),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}