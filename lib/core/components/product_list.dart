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
  final bool showFavourites; // NEW

  const ProductList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.showFavourites = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getProducts(query: query, category: category),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit homeCubit = context.read<HomeCubit>();

          List<ProductModel> products = showFavourites
              ? homeCubit.favouriteProductsList
              : query != null
                  ? homeCubit.searchResults
                  : category != null
                      ? homeCubit.categoryProduct
                      : homeCubit.products;

          return state is GetDataLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: shrinkWrap ?? true,
                  physics: physics ?? const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      isFavourit: homeCubit.checkIsFavourite(
                        products[index].productId!,
                      ),
                      onTap: () {
                        bool isFavourite = homeCubit.checkIsFavourite(
                          products[index].productId!,
                        );
                        isFavourite
                            ? homeCubit.removeProduct(
                                products[index].productId!,
                              )
                            : homeCubit.addProductToFavourite(
                                products[index].productId!,
                              );
                      },
                      product: products[index],
                    );
                  },
                );
        },
      ),
    );
  }
}
