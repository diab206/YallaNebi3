import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yalla_nebi3/core/components/cashed_network_image.dart';
import 'package:yalla_nebi3/core/components/user_comments.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';
import 'package:yalla_nebi3/models/product_model/product_model.dart';
import 'package:yalla_nebi3/views/product_details/logic/cubit/product_details_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProductDetailsCubit()..getRates(productId: product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: buildCustomAppBar(
              context,
              product.productName ?? 'Product Name',
            ),
            body: 
            state is ProductDetailsLoading?CircularProgressIndicator():
            ListView(
              children: [
                CahedNetworkImage(
                  url:
                      product.imageUrl ??
                      'https://images.pexels.com/photos/416753/pexels-photo-416753.jpeg',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.productName ?? 'Product Name'),
                          Text('${product.price}  LE'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(cubit.averageRate.toStringAsFixed(1)),
                               // Shows one decimal place),
                              Icon(Icons.star, color: Colors.amber),
                            ],
                          ),
                          Icon(Icons.favorite, color: AppColors.greyColor),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text('${product.description}'),
                      SizedBox(height: 30),
                      RatingBar.builder(
                        initialRating: cubit.userRate.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder:
                            (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          if (kDebugMode) {
                            print(rating);
                          }
                        },
                      ),
                      SizedBox(height: 40),
                      CustomTextFormField(
                        hintText: 'type your Feedback',

                        suffixIcon: Icon(Icons.send),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Comments', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          UserComments(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
