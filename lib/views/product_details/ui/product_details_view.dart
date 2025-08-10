import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yalla_nebi3/core/components/cashed_network_image.dart';
import 'package:yalla_nebi3/core/components/user_comments.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';
import 'package:yalla_nebi3/models/product_model/product_model.dart';
import 'package:yalla_nebi3/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:yalla_nebi3/views/product_details/logic/cubit/product_details_cubit.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProductDetailsCubit()
                ..getRates(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) async {
          if (state is AddOrUpdateRateSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ProductDetailsView(product: widget.product),
              ),
            );
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: buildCustomAppBar(
              context,
              widget.product.productName ?? 'Product Name',
            ),
            body:
                state is ProductDetailsLoading
                || state is AddCommentLoading
                    ? CircularProgressIndicator()
                    : ListView(
                      children: [
                        CahedNetworkImage(
                          url:
                              widget.product.imageUrl ??
                              'https://images.pexels.com/photos/416753/pexels-photo-416753.jpeg',
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.product.productName ??
                                        'Product Name',
                                  ),
                                  Text('${widget.product.price}  LE'),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cubit.averageRate.toStringAsFixed(1),
                                      ),
                                      // Shows one decimal place),
                                      Icon(Icons.star, color: Colors.amber),
                                    ],
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: AppColors.greyColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text('${widget.product.description}'),
                              SizedBox(height: 30),
                              RatingBar.builder(
                                initialRating: cubit.userRate.toDouble(),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                itemBuilder:
                                    (context, _) =>
                                        Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (rating) {
                                  cubit.addOrUpdateUserRate(
                                    productId: widget.product.productId!,
                                    data: {
                                      "rate": rating.toInt(),
                                      "for_user": cubit.userId,
                                      "for_product": widget.product.productId,
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 40),
                              CustomTextFormField(
                                hintText: 'type your Feedback',
                                controller: commentController,
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    cubit.addComment(
                                      data: {
                                      
                                        "comment": commentController.text,
                                        "for_user":
                                        cubit.userId,
                                        "for_product":
                                           widget.product.productId,
                                        "user_name":context.read<AuthenticationCubit>().userDataModel?.name ?? 'Anonymous'
                                        
                                      },
                                    );
                                    commentController.clear();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Comments',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  UserComments(productModel: widget.product,),
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

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
