import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/product_card.dart';
import 'package:yalla_nebi3/models/product_model/product_model.dart';
import 'package:yalla_nebi3/views/home/cubit/home_cubit.dart';

class ProductList extends StatelessWidget {
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  const ProductList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = context.read<HomeCubit>();
          List<ProductModel> products =
              query != null
                  ?homeCubit.searchResults
                  : category != null
                  ? homeCubit.categoryProduct
                  // If neither query nor category is provided, use all products
                  : homeCubit.products;
          return state is GetDataLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                shrinkWrap: shrinkWrap ?? true,
                physics: physics ?? NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    isFavourit: homeCubit.checkIsFavourite(products[index].productId!),
                   
                    onTap: (){
                      homeCubit.addProductToFavourite( products[index].productId!);
                    },
                    product: products[index]);
                },
              );
        },
      ),
    );
  }
}
