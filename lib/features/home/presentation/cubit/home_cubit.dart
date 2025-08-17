import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/core/services/api_services.dart';
import 'package:yalla_nebi3/features/favourite/data/models/favourite_product.dart';
import 'package:yalla_nebi3/features/home/data/models/product_model.dart';
import 'package:yalla_nebi3/features/home/data/models/purchase_table.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiServices _apiServices = ApiServices();

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProduct = [];
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  Future<void> getProducts({String? query, String? category}) async {
    products.clear();
    searchResults.clear();
    categoryProduct.clear();
    favouriteProducts.clear();
    userOrders.clear();
    if (!isClosed) emit(GetDataLoading());

    try {
      Response response = await _apiServices.getData(
        'products_table?select=*,favourit_products(*),purchase_table!purchase_tablr_for_product_fkey(*)',
      );

      if (isClosed) return;

      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }

      // synchronous helpers
      getFavouriteProducts();

      // Filter products based on query and category
      search(query);
      getProductsByCatogries(category);
      getUserOrdersProducts();

      if (!isClosed) emit(GetDataSucess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(GetDataError());
    }
  }

  void search(String? query) {
    searchResults.clear();
    if (query != null && query.trim().isNotEmpty) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProductsByCatogries(String? catagory) {
    categoryProduct.clear();
    if (catagory != null) {
      for (var product in products) {
        if (product.category!.trim().toLowerCase() ==
            catagory.trim().toLowerCase()) {
          categoryProduct.add(product);
        }
      }
    }
  }

  Map<String, bool> favouriteProducts = {};

  Future<void> addProductToFavourite(String productId) async {
    if (!isClosed) emit(AddProductToFavouriteLoading());
    try {
      await _apiServices.postData("favourit_products", {
        "is_favourit": true,
        'for_user': userId,
        'for_product': productId,
      });

      // refresh products
      await getProducts();
      if (isClosed) return;

      favouriteProducts[productId] = true;
      if (!isClosed) emit(AddProductToFavouriteSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(AddProductToFavouriteError());
    }
  }

  bool checkIsFavourite(String productId) {
    return favouriteProducts.containsKey(productId);
  }

  // Remove product from favourites
  Future<void> removeProduct(String productId) async {
    if (!isClosed) emit(RemoveProductFromFavouriteLoading());
    try {
      await _apiServices.deleteData(
        "favourit_products?for_user=eq.$userId&for_product=eq.$productId",
      );

      // refresh products
      await getProducts();
      if (isClosed) return;

      favouriteProducts.removeWhere((key, value) => key == productId);
      if (!isClosed) emit(RemoveProductFromFavouriteSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(RemoveProductFromFavouriteError());
    }
  }

  // get favourite products
  List<ProductModel> favouriteProductsList = [];

  void getFavouriteProducts() {
    favouriteProductsList.clear();
    favouriteProducts.clear();

    for (ProductModel product in products) {
      if (product.favouritProducts != null &&
          product.favouritProducts!.isNotEmpty) {
        for (FavouritProduct favouritProduct in product.favouritProducts!) {
          if (favouritProduct.forUser == userId) {
            favouriteProductsList.add(product);
            favouriteProducts[product.productId!] = true;
          }
        }
      }
    }
  }

  Future<void> buyProduct({required String productId}) async {
    emit(BuyProductLoading());
    try {
      await _apiServices.postData("purchase_table", {
        "is_bought": true,
        "for_user": userId,
        "for_product": productId,
      });
      emit(BuyProductSuccess());
    } catch (e) {
      log(e.toString());
      emit(BuyProductFailure());
    }
  }
  // Get user orders
  List<ProductModel> userOrders = [];

  void getUserOrdersProducts() {
   

    for (ProductModel product in products) {
      if (product.purchaseTable != null &&
          product.purchaseTable!.isNotEmpty) {
        for (PurchaseTable purchase in product.purchaseTable!) {
          if (purchase.forUser == userId) {
            userOrders.add(product);  
          }
        }
      }
    }
  }
}
