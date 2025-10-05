import 'package:flutter/material.dart';
import 'package:nvisust_task/features/auth/helpers/appcolors.dart';
import 'package:nvisust_task/features/auth/helpers/screen_config.dart';
import 'package:nvisust_task/features/auth/helpers/size_extension.dart';
import 'package:nvisust_task/features/auth/helpers/sizedbox.dart';
import 'package:nvisust_task/features/auth/screens/profile_screen.dart';
import 'package:nvisust_task/features/auth/screens/register_screen.dart';
import 'package:nvisust_task/features/auth/state/auth_provider.dart';
import 'package:nvisust_task/features/auth/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              // textfield section
              textfieldsection(provider),
              sizedBoxWithHeight(20),
              // Login button
              loginbutton(provider, context),
              sizedBoxWithHeight(20),
              // registration option row
              registrationoptionrow(context),
            ],
          ),
        ),
      ),
    );
  }

  // registration option row
  Row registrationoptionrow(BuildContext context) {
    return Row(
      children: [
        Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: Text(
            "Register",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }

  // login button
  Align loginbutton(AuthProvider provider, BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          final provider = Provider.of<AuthProvider>(context, listen: false);

          // Step 1: Validate form
          if (provider.loginFormKey.currentState!.validate()) {
            final loginEmail = provider.loginEmailController.text.trim();
            final loginPassword = provider.loginPasswordController.text.trim();

            // Step 2: Retrieve stored credentials from SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            final savedEmail = prefs.getString('email');
            final savedPassword = prefs.getString('password');

            // Step 3: Check if user is registered
            if (savedEmail == null || savedPassword == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("User not registered. Please sign up first."),
                ),
              );
              return;
            }

            // Step 4: Match login credentials
            if (loginEmail == savedEmail && loginPassword == savedPassword) {
              await provider.loginUser();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Login successful"),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Invalid email or password."),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Please enter valid login details."),
              ),
            );
          }
        },
        // onTap: () {
        //   if (provider.loginFormKey.currentState!.validate()) {
        //     provider.loginUser();
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => ProfileScreen()),
        //     );
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         backgroundColor: AppColors.green,
        //         content: Text("login successfully"),
        //       ),
        //     );
        //   } else {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         backgroundColor: AppColors.red,
        //         content: Text("Please login properly"),
        //       ),
        //     );
        //   }
        // },
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
                    "LOGIN",
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

  // textfield section
  Form textfieldsection(AuthProvider provider) {
    return Form(
      key: provider.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            textfieldcontroller: provider.loginEmailController,
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
            textfieldcontroller: provider.loginPasswordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              if (value.length < 5) {
                return "Password must s at least 5 characters";
              }
              return null;
            },
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
        "LOGIN",
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
