part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetDataLoading extends HomeState {}

final class GetDataSucess extends HomeState {}

final class GetDataError extends HomeState {}

final class AddProductToFavouriteLoading extends HomeState {}

final class AddProductToFavouriteError extends HomeState {}

final class AddProductToFavouriteSuccess extends HomeState {}

final class RemoveProductFromFavouriteLoading extends HomeState {}

final class RemoveProductFromFavouriteError extends HomeState {}

final class RemoveProductFromFavouriteSuccess extends HomeState {}

final class BuyProductSuccess extends HomeState {}

final class BuyProductLoading extends HomeState {}

final class BuyProductFailure extends HomeState {}