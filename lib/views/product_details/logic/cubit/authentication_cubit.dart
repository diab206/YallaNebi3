import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final AuthResponse response = await client.auth.signInWithPassword(
        password: password, 
        email: email
      );
      
      if (response.user != null) {
        log('Login successful for user: ${response.user!.email}');
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errorMessage: 'Login failed'));
      }
    } on AuthException catch (e) {
      log('Auth Exception: ${e.toString()}');
      emit(LoginFailure(errorMessage: e.message));
    } catch (e) {
      log('General Exception: ${e.toString()}');
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email, 
    required String password
  }) async {
    emit(SignUpLoading());
    try {
      await client.auth.signUp( email: email,password: password);
      addUserData(email: email, name: name);
       emit(SignUpSuccess());
    }
    on AuthException catch (e) {
      log('Auth Exception during registration: ${e.toString()}');
      emit(SignUpFailure(errorMessage: e.message));
    } catch (e) {
      log('General Exception during registration: ${e.toString()}');
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
      
      
    

  // Helper method to get current user
  User? getCurrentUser() {
    return client.auth.currentUser;
  }

  // Helper method to sign out
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(LogoutFailure());
    }
  }
  Future<void> resetPassword(String email) async {
    emit(ResetpasswordLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(ResetpasswordSuccess());
    } catch (e) {
      log(e.toString());
      emit(ResetpasswordFailure());
    } 
  }
  Future<void> addUserData({required String name, required String email })async{
    emit(UserDataAddedLoading());
    try {
      await client.from('users').insert({
        'id': client.auth.currentUser?.id,
        'name': name,
        'email': email,
      });
      emit(UserDataAddedSuccess());
    }catch(e){
      log(e.toString());
      emit(UserDataAddedFailure());
    }

  }
}