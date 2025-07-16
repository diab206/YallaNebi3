import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/widgets/custom_search_bar.dart';

class HomeViews extends StatelessWidget {
   HomeViews({super.key});
 final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomSearchBar(
  controller: searchController,
  hintText: 'Search in Market....',
  onSearch: () {
  },
),
          ]
        ),
        
        ),
    );
      
  }
}