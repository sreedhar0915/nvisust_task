import 'package:flutter/material.dart';
import 'package:nvisust_task/features/auth/helpers/appcolors.dart';
import 'package:nvisust_task/features/auth/helpers/screen_config.dart';
import 'package:nvisust_task/features/auth/helpers/size_extension.dart';
import 'package:nvisust_task/features/auth/helpers/sizedbox.dart';
import 'package:nvisust_task/features/auth/screens/login_screen.dart';
import 'package:nvisust_task/features/auth/state/auth_provider.dart';
import 'package:nvisust_task/features/auth/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>(); //calling provider
    ScreenUtil.getInstance().init(context); //using mediaquery
    return Scaffold(
      appBar: appbarsection(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textfieldsection(provider),
              sizedBoxWithHeight(20),

              registrationbutton(provider, context),
              sizedBoxWithHeight(20),
              loginoptionrow(context),
            ],
          ),
        ),
      ),
    );
  }

  //registration button
  Align registrationbutton(AuthProvider provider, BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          if (provider.formKey.currentState!.validate()) {
            provider.registerUser();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.green,
                content: Text("Registration successfully"),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.red,
                content: Text("Please register properly"),
              ),
            );
          }
        },
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.black),
          ),
          child: Center(
            child: provider.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    "REGISTER",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  // login option row
  Align loginoptionrow(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        children: [
          Text("Don't have an account?"),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // textfield section
  Form textfieldsection(AuthProvider provider) {
    return Form(
      key: provider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name field
          Text(
            "Name:",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          sizedBoxWithHeight(5),
          CustomTextfield(
            hinttext: "ENTER THE NAME",
            textfieldcontroller: provider.nameController,
            obscureText: false,
            validator: (value) {
              if (provider.nameController.text.length <= 2) {
                return "enter valid name";
              } else if (value!.isEmpty) {
                return "enter password";
              } else {
                return null;
              }
            },
          ),
          sizedBoxWithHeight(10),

          // Email
          Text(
            "Email ID:",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          sizedBoxWithHeight(5),
          CustomTextfield(
            hinttext: "ENTER EMAIL ADDRESS",
            textfieldcontroller: provider.emailController,
            obscureText: false,
            validator: (value) {
              if (value == null ||
                  !provider.emailController.text.contains("@gmail.com")) {
                return "Please enter a valid email address";
              }
              return null;
            },
          ),
          sizedBoxWithHeight(10),

          // Password
          Text(
            "Password:",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          sizedBoxWithHeight(5),
          CustomTextfield(
            hinttext: "ENTER THE PASSWORD",
            textfieldcontroller: provider.passwordController,
            obscureText: !provider.ispasswoedvisible,
            validator: (value) {
              if (provider.passwordController.text.length < 5) {
                return "password must contain atleast 5 characters";
              } else if (value!.isEmpty) {
                return "enter password";
              } else {
                return null;
              }
            },
          ),
          sizedBoxWithHeight(10),

          // Confirm password
          Text(
            "Confirm Password:",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          sizedBoxWithHeight(5),
          CustomTextfield(
            hinttext: "ENTER THE CONFIRM PASSWORD",
            textfieldcontroller: provider.confirmPasswordController,
            obscureText: !provider.ispasswoedvisible,
            validator: (value) {
              if (provider.confirmPasswordController.text.isEmpty) {
                return "confirm password";
              } else if (provider.confirmPasswordController.text !=
                  provider.confirmPasswordController.text) {
                return "password do not match";
              } else {
                return null;
              }
            },
          ),

          // Show password
          Row(
            children: [
              Checkbox(
                value: provider.ispasswoedvisible,
                onChanged: (bool? value) {
                  setState(() {
                    provider.ispasswoedvisible = value!;
                  });
                },
              ),
              const Text("Show Password"),
            ],
          ),
        ],
      ),
    );
  }

  // appbar section
  AppBar appbarsection() {
    return AppBar(
      backgroundColor: AppColors.blue,
      surfaceTintColor: AppColors.blue,
      title: Text(
        "REGISTRATION",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      centerTitle: true,
    );
  }
}
