import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/core/api_services.dart';
import 'package:yalla_nebi3/models/product_model/favourit_product.dart';
import 'package:yalla_nebi3/models/product_model/product_model.dart';
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
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
        'products_table?select=*,favourit_products(*),purchase_table!purchase_tablr_for_product_fkey(*)',
      );
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
      getFavouriteProducts();
      // Filter products based on query and category
      search(query);
      getProductsByCatogries(category);
      emit(GetDataSucess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
  }

  void getProductsByCatogries(String? catagory) {
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
    emit(AddProductToFavouriteLoading());
    try {
      await _apiServices.postData("favourit_products", {
        "is_favourit": true,
        'for_user': userId,
        'for_product': productId,
      });
      await getProducts();
      favouriteProducts.addAll({productId: true});
      emit(AddProductToFavouriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddProductToFavouriteError());
    }
  }

  bool checkIsFavourite(String productId) {
    return favouriteProducts.containsKey(productId);
  }

  // Remove product from favourites
  Future<void> removeProduct(String productId) async {
    emit(RemoveProductFromFavouriteLoading());
    try {
      await _apiServices.deleteData(
        "favourit_products?for_user=eq.$userId&for_product=eq.$productId",
      );
      await getProducts();
      favouriteProducts.removeWhere((key, value) => key == productId);
      emit(RemoveProductFromFavouriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveProductFromFavouriteError());
    }
  }
  // get favourite products

  List<ProductModel> favouriteProductsList = [];

void getFavouriteProducts() {
  favouriteProductsList.clear();
  favouriteProducts.clear();

  for (ProductModel product in products) {
    if (product.favouritProducts != null && product.favouritProducts!.isNotEmpty) {
      for (FavouritProduct favouritProduct in product.favouritProducts!) {
        if (favouritProduct.forUser == userId) {
          favouriteProductsList.add(product);
          favouriteProducts[product.productId!] = true;
        }
      }
    }
  }

  if (favouriteProductsList.isNotEmpty) {
    log(favouriteProductsList[0].productName.toString());
  }
}

  }

