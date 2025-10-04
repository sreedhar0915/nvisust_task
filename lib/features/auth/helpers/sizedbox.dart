import 'package:flutter/material.dart';
import 'package:nvisust_task/features/auth/helpers/size_extension.dart';

Widget sizedBoxWithHeight(int? height) {
  return SizedBox(height: height!.h);
}

Widget sizedBoxWithWidth(int? width) {
  return SizedBox(width: width!.w);
}
