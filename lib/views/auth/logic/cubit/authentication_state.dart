part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}


final class LoginSuccess extends AuthenticationState {}
final class LoginLoading extends AuthenticationState {}
final class LoginFailure extends AuthenticationState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
final class SignUpSuccess extends AuthenticationState {}
final class SignUpLoading extends AuthenticationState {}
final class SignUpFailure extends AuthenticationState {
  final String errorMessage;

  SignUpFailure({required this.errorMessage});
}
final class LogoutSuccess extends AuthenticationState {}
final class LogoutLoading extends AuthenticationState {}
final class LogoutFailure extends AuthenticationState {
}
final class ResetpasswordSuccess extends AuthenticationState {}
final class ResetpasswordLoading extends AuthenticationState {}
final class ResetpasswordFailure extends AuthenticationState {
}
final class UserDataAddedSuccess extends AuthenticationState {}
final class UserDataAddedLoading extends AuthenticationState {}
final class UserDataAddedFailure extends AuthenticationState {
}
final class GetUserDataSuccess extends AuthenticationState {}
final class GetUserDataLoading extends AuthenticationState {}
final class GetUserDataFailure extends AuthenticationState {
}
