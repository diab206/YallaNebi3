import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/custom_search_bar.dart';
import 'package:yalla_nebi3/core/components/product_list.dart';

class StoreView extends StatelessWidget {
   StoreView({super.key});
    final searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Welcome To Our Market', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          CustomSearchBar(
            controller: searchController,
            hintText: 'Search in Market....',
            onSearch: () {},
          ),
          const SizedBox(height: 16),
         ProductList()
        ],
      ),
    );
  }
}



 