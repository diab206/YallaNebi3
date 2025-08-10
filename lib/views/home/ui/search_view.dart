import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/product_list.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String routeName = "search_view";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Search_results"),

      body: ListView(
        children: [
          Center(child: SizedBox(height: 15)),
          ProductList(),
        ],
      ),
    );
  }
}
