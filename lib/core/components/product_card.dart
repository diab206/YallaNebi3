import 'package:flutter/material.dart';
import 'package:yalla_nebi3/core/components/cashed_network_image.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/core/functions/naviagte_to.dart';
import 'package:yalla_nebi3/core/widgets/custom_action_button.dart';
import 'package:yalla_nebi3/models/product_model/product_model.dart';
import 'package:yalla_nebi3/views/product_details/ui/product_details_view.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onTap,  required this.isFavourit,});
  final ProductModel product;
  final Function()? onTap;
  final bool isFavourit;  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigteTo(context, ProductDetailsView(product: product,));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  child: CahedNetworkImage(
                    url:
                        product.imageUrl ??
                        'https://images.pexels.com/photos/416753/pexels-photo-416753.jpeg',
                  ),
                ),
                Positioned(
                  child: Container(
                    //   color: AppColors.primaryColor,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                    ),
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '${product.sale} % OFF ',
                      style: TextStyle(
                        color: AppColors.backgroundcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.productName ?? 'Product Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: onTap,
                        icon: Icon(
                          Icons.favorite,
                          color:isFavourit? AppColors.primaryColor: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${product.price}  LE',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product.oldPrice}  LE',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),

                      CustomActionButton(onPressed: () {}, text: 'Buy Now'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
