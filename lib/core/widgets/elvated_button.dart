import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomElevatedIconButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.backgroundcolor,
          shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(16),
  side: const BorderSide(
    color: AppColors.primaryColor,
    width: 2,
  ),
),

          padding: const EdgeInsets.all(16), // More padding → bigger circle
          elevation: 4,
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: AppColors.backgroundcolor,
          size: 26, // Optional: increase icon size too
        ),
      ),
    );
  }
}
