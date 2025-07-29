import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/product_list.dart';

class FavouritView extends StatelessWidget {
  const FavouritView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Your Favourits Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          ProductList(),
        ],
      ),
    );
  }
}
