import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yalla_nebi3/core/components/cashed_network_image.dart';
import 'package:yalla_nebi3/core/components/user_comments.dart';
import 'package:yalla_nebi3/core/const/app_colors.dart';
import 'package:yalla_nebi3/core/functions/custom_app_bar.dart';
import 'package:yalla_nebi3/core/widgets/text_form_field.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, 'Product Name'),
      body: ListView(
        children: [
          CahedNetworkImage(
            url:
                'https://images.pexels.com/photos/416753/pexels-photo-416753.jpeg',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Product Name'), Text('123 LE')],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('3  '),
                        Icon(Icons.star, color: Colors.amber),
                      ],
                    ),
                    Icon(Icons.favorite, color: AppColors.greyColor),
                  ],
                ),
                SizedBox(height: 30),
                Text('Product Description'),
                SizedBox(height: 30),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.amber),
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
                      Text('Comments',style: TextStyle(
                        fontSize: 20
                       
                      )),
                    ],
                  ),
                  UserComments()
                  
                  ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
