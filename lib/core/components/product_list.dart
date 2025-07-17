import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/product_card.dart';

class ProductList extends StatelessWidget {
final bool? shrinkWrap;
final ScrollPhysics? physics;
  const ProductList({
    super.key, this.shrinkWrap, this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
     shrinkWrap: shrinkWrap ?? true,
     physics:physics?? NeverScrollableScrollPhysics(),
     itemCount: 10,
     itemBuilder: (context, index) {
     return  ProductCard();
    });
  }
}
