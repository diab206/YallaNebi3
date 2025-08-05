part of 'product_details_cubit.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}
final class ProductDetailsLoading extends ProductDetailsState {}
final class ProductDetailsSuccess extends ProductDetailsState {}
final class ProductDetailsError extends ProductDetailsState {}


final class AddOrUpdateRateLoading extends ProductDetailsState {}
final class AddOrUpdateRateSuccess extends ProductDetailsState {}
final class AddOrUpdateRateError extends ProductDetailsState {}
