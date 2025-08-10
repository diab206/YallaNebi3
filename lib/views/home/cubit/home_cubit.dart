import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/core/api_services.dart';
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
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
        'products_table?select=*,favourit_products(*),purchase_table!purchase_tablr_for_product_fkey(*)',
      );
      for (var product in response.data) {
        products.add(ProductModel.fromJson(product));
      }
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

  Future<void> addProductToFavourite(String productId) async {
    emit(AddProductToFavouriteLoading());
    try {
      await _apiServices.postData("favourit_products", {
        "is_favourit": true,
        'for_user': userId,
        'for_product': productId,
      });
      emit(AddProductToFavouriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddProductToFavouriteError());
    }
  }
}
