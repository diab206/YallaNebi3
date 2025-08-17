import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/constants/app_colors.dart';

AppBar buildCustomAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: AppColors.backgroundcolor),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: AppColors.backgroundcolor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    backgroundColor: AppColors.primaryColor,
  );
}
