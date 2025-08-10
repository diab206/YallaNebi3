import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/product_list.dart';
import 'package:yalla_nebi3/core/components/custom_search_bar.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
import 'package:yalla_nebi3/core/widgets/catagries_list.dart';
import 'package:yalla_nebi3/views/home/ui/search_view.dart';

class HomeViews extends StatefulWidget {
  const HomeViews({super.key});

  @override
  State<HomeViews> createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          CustomSearchBar(
            controller: searchController,
            hintText: 'Search in Market....',
            onSearch: () {
              if (searchController.text.isNotEmpty) {
                 navigteTo(context, SearchView(query: searchController.text));
                 searchController.clear();
              }
              
            },
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
          ProductList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
