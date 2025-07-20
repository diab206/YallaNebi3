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
      log('Attempting to register user: $email');
      
      final AuthResponse response = await client.auth.signUp(
        password: password, 
        email: email,
        data: {'name': name}, // Store the name in user metadata
      );
      
      if (response.user != null) {
        log('Registration successful for user: ${response.user!.email}');
        // Check if email confirmation is required
        if (response.session != null) {
          // User is immediately signed in (email confirmation disabled)
          emit(SignUpSuccess());
        } else {
          // Email confirmation required
          emit(SignUpSuccess()); // You might want to create a different state for this
        }
      } else {
        log('Registration failed: No user returned');
        emit(SignUpFailure(errorMessage: 'Registration failed'));
      }
    } on AuthException catch (e) {
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
      emit(AuthenticationInitial());
    } catch (e) {
      log('Sign out error: ${e.toString()}');
    }
  }
}