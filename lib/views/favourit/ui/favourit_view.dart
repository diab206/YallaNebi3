import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yalla_nebi3/core/components/product_list.dart';
import 'package:yalla_nebi3/views/home/cubit/home_cubit.dart';

class FavouritView extends StatelessWidget {
  const FavouritView({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (_) => HomeCubit()..getFavouriteProducts(),
    child:  SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Your Favourite Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),

          // Show only favourite products
          ProductList(showFavourites: true),
        ],
      ),
    ) );
  }
}
