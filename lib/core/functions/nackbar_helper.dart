import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor:AppColors.primaryColor,
    ),
  );
}
