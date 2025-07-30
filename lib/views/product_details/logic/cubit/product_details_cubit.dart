import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:yalla_nebi3/core/api_services.dart';
import 'package:yalla_nebi3/views/product_details/models/rates.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
 final ApiServices _apiService = ApiServices();
 List <Rates> rates = [];

 Future<void>getRates({required String productId}) async {
  emit(ProductDetailsLoading());
  try {
    Response response = await _apiService.getData
    ('rates_table?select=*&for_product=eq.$productId');
     for(var rate in response.data) {
      rates.add(Rates.fromJson(rate));
 }
 emit(ProductDetailsSuccess());
 }
 catch (e) {
  log(e.toString());
    emit(ProductDetailsError());
  }

 }
}