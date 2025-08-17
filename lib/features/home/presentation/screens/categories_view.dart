import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/utils/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/product_list.dart';

class CatogriesView extends StatelessWidget {
  const CatogriesView({super.key,  required this.category});
  
  final String category ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, category),
      body: ListView(
        children: [
          Center(child: SizedBox(height: 15)),
          ProductList(category: category,),
        ],
      ),
    );
  }
}
