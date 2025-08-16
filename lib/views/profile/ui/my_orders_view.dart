import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/product_list.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';

class MyOrdersView extends StatelessWidget {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, 'My Orders'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductList(
          isMyOrdersViews: true,
          shrinkWrap: true, physics: BouncingScrollPhysics()),
      ),
    );
  }
}
