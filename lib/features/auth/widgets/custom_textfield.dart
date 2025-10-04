import 'package:flutter/material.dart';
import 'package:nvisust_task/features/auth/helpers/appcolors.dart';

class CustomTextfield extends StatelessWidget {
  final String hinttext;
  final TextEditingController textfieldcontroller;
  final dynamic obscureText;
  final dynamic validator;
  const CustomTextfield({
    super.key,
    required this.hinttext,
    required this.textfieldcontroller,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: textfieldcontroller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hinttext,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: AppColors.white, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: AppColors.blue, width: 1),
          ),
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(50),
          //   borderSide: BorderSide(color: AppColors.red, width: 1),
          // ),
          fillColor: AppColors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
