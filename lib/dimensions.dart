import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {
  static double height(double height){
    return Get.context!.height*height/100.0;
  } 

  static double width(double width){
    return Get.context!.width*width/100.0;
  }

  static double smallest(double size){
    return min(height(size), width(size));
  }

  static double greatest(double size){
    return max(height(size), width(size));
  }

  static Widget sizeVer(double height) {
    return SizedBox(height: Dimensions.height(height));
  }

  static Widget sizeHor(double width) {
    return SizedBox(width: Dimensions.width(width));
  }
}