import 'package:flutter/material.dart';
import 'package:nvisust_task/features/auth/helpers/appcolors.dart';
import 'package:nvisust_task/features/auth/helpers/sizedbox.dart';

class ProductCard extends StatelessWidget {
  final String productname;
  final String description;
  final String imageurl;
  const ProductCard({
    super.key,
    required this.productname,
    required this.description,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.zero,
        ),
        border: Border.all(color: AppColors.blue),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
              width: 116,
              decoration: BoxDecoration(
                color: AppColors.white,
                image: DecorationImage(
                  image: NetworkImage(imageurl),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          sizedBoxWithWidth(5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    productname,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
