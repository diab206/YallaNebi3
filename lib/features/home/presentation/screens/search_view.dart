import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/utils/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/product_list.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Search_results"),

      body: ListView(
        children: [
          Center(child: SizedBox(height: 15)),
          ProductList(query: query,),
        ],
      ),
    );
  }
}
