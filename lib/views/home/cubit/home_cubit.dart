import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:yalla_nebi3/core/api_services.dart';
import 'package:yalla_nebi3/models/product_model/product_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ApiServices _apiServices = ApiServices();
  List<ProductModel> products = [];
  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
        'products_table?select=*,favourit_products(*),purchase_table!purchase_tablr_for_product_fkey(*)',
      );
      for (var product in response. data) {
        products.add(ProductModel.fromJson(product));
      }
      emit(GetDataSucess());
    } catch (e) {
      log(e.toString());
      emit(GetDataError());
    }
  }
}
