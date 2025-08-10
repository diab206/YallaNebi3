import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/product_card.dart';
import 'package:yalla_nebi3/models/product_model/product_model.dart';
import 'package:yalla_nebi3/views/home/cubit/home_cubit.dart';

class ProductList extends StatelessWidget {
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  const ProductList({super.key, this.shrinkWrap, this.physics, this.query});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(query: query),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<ProductModel> products = query !=null ? context.read<HomeCubit>().searchResults : context.read<HomeCubit>().products;
          return state is GetDataLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                shrinkWrap: shrinkWrap ?? true,
                physics: physics ?? NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              );
        },
      ),
    );
  }
}
