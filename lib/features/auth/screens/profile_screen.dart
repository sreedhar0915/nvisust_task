import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nvisust_task/features/auth/helpers/appcolors.dart';
import 'package:nvisust_task/features/auth/helpers/screen_config.dart';
import 'package:nvisust_task/features/auth/helpers/sizedbox.dart';
import 'package:nvisust_task/features/auth/screens/login_screen.dart';
import 'package:nvisust_task/features/auth/state/auth_provider.dart';
import 'package:nvisust_task/features/auth/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<AuthProvider>(context, listen: false).fetchAllProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>(); //calling provider
    ScreenUtil.getInstance().init(context); //using mediaquery
    return Scaffold(
      appBar: appbarsection(provider),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // imagepicker section  DP
              imagepickersection(provider),
              sizedBoxWithHeight(20),
              //name section
              namesection(provider),
              sizedBoxWithHeight(20),
              //email section
              emailsection(provider),
              sizedBoxWithHeight(20),
              // Logout button
              logoutbutton(provider, context),
              sizedBoxWithHeight(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product list",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //  navigate to a "View All Products" screen here
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              sizedBoxWithHeight(20),
              //  Product List
              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : productlist(provider),
            ],
          ),
        ),
      ),
    );
  }

  //productlist
  Column productlist(AuthProvider provider) {
    return Column(
      children: List.generate(
        provider.productsList.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () {
              // open product detail page
            },
            child: ProductCard(
              imageurl: provider.productsList[index].image.toString(),
              productname: provider.productsList[index].title.toString(),
              description: provider.productsList[index].description.toString(),
            ),
          ),
        ),
      ),
    );
  }

  // logout button
  Align logoutbutton(AuthProvider provider, BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          await provider.logoutUser();
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
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
            child: Text(
              "LOGOUT",
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

  // email section
  Row emailsection(AuthProvider provider) {
    return Row(
      children: [
        Text(
          "Email ID :",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        sizedBoxWithWidth(10),
        Text(
          provider.currentUser?.email ?? "No email",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  //name section
  Row namesection(AuthProvider provider) {
    return Row(
      children: [
        Text(
          "Name :",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        sizedBoxWithWidth(10),
        Text(
          provider.currentUser?.name ?? "Guest",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  // profile photo
  Align imagepickersection(AuthProvider provider) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
          );
          if (image != null) {
            setState(() {
              provider.imagepath = image.path;
            });
          }
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: AppColors.blue,
            border: Border.all(color: AppColors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          child: provider.imagepath != null
              ? Image.file(File(provider.imagepath!), fit: BoxFit.cover)
              : Image.asset(
                  "assets/images/profiledp-removebg-preview.png",
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  //appbar section
  AppBar appbarsection(AuthProvider provider) {
    return AppBar(
      backgroundColor: AppColors.blue,
      surfaceTintColor: AppColors.blue,
      title: Text(
        "PROFILE",
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
