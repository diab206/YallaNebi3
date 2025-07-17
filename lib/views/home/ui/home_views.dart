import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/widgets/custom_search_bar.dart';
import 'package:yalla_nebi3/views/home/widgets/catagries_list.dart';

class HomeViews extends StatelessWidget {
  HomeViews({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchBar(
            controller: searchController,
            hintText: 'Search in Market....',
            onSearch: () {},
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/home_main.png',
            width: double.infinity,
            height: 250,
          ),
          const SizedBox(height: 16),
          const Text('Popular Categories', style: TextStyle(fontSize: 15)),
          const SizedBox(height: 8),
          CatagriesList(),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                      child: Image.network(
                        'https://images.pexels.com/photos/416753/pexels-photo-416753.jpeg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
