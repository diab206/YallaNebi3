import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/utils/snackbar_helper.dart';
import 'package:yalla_nebi3/core/widgets/product_card.dart';
import 'package:yalla_nebi3/features/home/data/models/product_model.dart';
import 'package:yalla_nebi3/features/home/presentation/cubit/home_cubit.dart';


class ProductList extends StatelessWidget {
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool showFavourites;
  final bool isMyOrdersViews;

  const ProductList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.showFavourites = false,
   this. isMyOrdersViews = false,
  });

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) =>
        HomeCubit()..getProducts(query: query, category: category),
    child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is BuyProductSuccess) {
          showAppSnackBar(context, 'Payment Success, check out your Orders');
        }
        if (state is BuyProductFailure) {
          showAppSnackBar(context, 'Payment failed. Please try again.');
        }
      },
      builder: (context, state) {
        HomeCubit homeCubit = context.read<HomeCubit>();

        List<ProductModel> products;

        if (showFavourites) {
          products = homeCubit.favouriteProductsList;
        } else if (isMyOrdersViews) {
          products = homeCubit.userOrders;
        } else if (query != null) {
          products = homeCubit.searchResults;
        } else if (category != null) {
          products = homeCubit.categoryProduct;
        } else {
          products = homeCubit.products;
        }

        if (state is GetDataLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: shrinkWrap ?? true,
          physics: physics ?? const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final isFavourite = homeCubit.checkIsFavourite(product.productId!);

            return ProductCard(
              onPaymentSuccess: () {
              homeCubit.buyProduct(productId: product.productId!);
              },
              isFavourit: isFavourite,
              onTap: () {
              isFavourite
                ? homeCubit.removeProduct(product.productId!)
                : homeCubit.addProductToFavourite(product.productId!);
              },
              product: product,
            );
          },
        );
      },
    ),
  );
}
}