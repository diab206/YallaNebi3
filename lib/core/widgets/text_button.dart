import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;


  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8), // Optional ripple shape
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          text,
          style: const TextStyle(
            color:AppColors. primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
 