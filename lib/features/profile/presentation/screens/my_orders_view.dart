import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/utils/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/product_list.dart';

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
