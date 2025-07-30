import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/core/api_services.dart';
import 'package:yalla_nebi3/views/product_details/models/rates.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final ApiServices _apiService = ApiServices();
  List<Rates> rates =
      []; //for user =user id  we will use it later for making filitring with where
  double averageRate = 0.0;
  int userRate = 5;

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      Response response = await _apiService.getData(
        'products_table?select=*&id=eq.$productId',
      );
      if (response.data.isNotEmpty) {
        for (var rate in response.data) {
          rates.add(Rates.fromJson(rate));
        }
        

        emit(ProductDetailsSuccess());
      } else {
        emit(ProductDetailsError());
      }
    } catch (e) {
      log(e.toString());
      emit(ProductDetailsError());
    }
  }

  Future<void> getRates({required String productId}) async {
    emit(ProductDetailsLoading());
    try {
      Response response = await _apiService.getData(
        'rates_table?select=*&for_product=eq.$productId',
      );
      for (var rate in response.data) {
        rates.add(Rates.fromJson(rate));
      }
      getAverageRate();
        _getUserRate();

      emit(ProductDetailsSuccess());
    } catch (e) {
      log(e.toString());
      emit(ProductDetailsError());
    }
  }

  void _getUserRate() {
     List<Rates> userRates =
        rates
            .where(
              (Rates rate) =>
                  rate.forUser ==
                  Supabase.instance.client.auth.currentUser!.id,
            )
            .toList();
    
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!; //user rate
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
