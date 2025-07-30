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
  double averageRate = 0.0;

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      Response response = await _apiService.getData('products_table?select=*&id=eq.$productId');
      if (response.data.isNotEmpty) {
        for (var rate in response.data) {
          rates.add(Rates.fromJson(rate));
        }
       getAverageRate();
        emit(ProductDetailsSuccess());
      } else {
        emit(ProductDetailsError());
      }
    } catch (e) {
      log(e.toString());
      emit(ProductDetailsError());
    }
  }

 Future<void>getRates({required String productId}) async {
  emit(ProductDetailsLoading());
  try {
    Response response = await _apiService.getData
    ('rates_table?select=*&for_product=eq.$productId');
     for(var rate in response.data) {
      rates.add(Rates.fromJson(rate));
 }
    getAverageRate();
   
 emit(ProductDetailsSuccess());
 }
 catch (e) {
  log(e.toString());
    emit(ProductDetailsError());
  }

 }
 void getAverageRate() {
    if (rates.isEmpty) {
      averageRate = 0.0;
      return;
    }
    
    int totalRate = 0;
    int validRatesCount = 0;
    
    for (var userRate in rates) {
      if (userRate.rate != null) {
        totalRate += userRate.rate!;
        validRatesCount++;
      }
    }
    
    if (validRatesCount > 0) {
      averageRate = totalRate / validRatesCount;
    } else {
      averageRate = 0.0;
    }
  }
}