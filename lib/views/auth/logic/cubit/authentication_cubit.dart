import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/core/models/user_data_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  final SupabaseClient client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    if (!isClosed) emit(LoginLoading());
    try {
      final AuthResponse response = await client.auth.signInWithPassword(
        password: password,
        email: email,
      );

      // Await getUserData so we only proceed after its completion
      await getUserData();
      if (isClosed) return;

      if (response.user != null) {
        log('Login successful for user: ${response.user!.email}');
        if (!isClosed) emit(LoginSuccess());
      } else {
        if (!isClosed) emit(LoginFailure(errorMessage: 'Login failed'));
      }
    } on AuthException catch (e) {
      log('Auth Exception: ${e.toString()}');
      if (!isClosed) emit(LoginFailure(errorMessage: e.message));
    } catch (e) {
      log('General Exception: ${e.toString()}');
      if (!isClosed) emit(LoginFailure(errorMessage: e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!isClosed) emit(SignUpLoading());
    try {
      await client.auth.signUp(email: email, password: password);
      if (isClosed) return;

      // Ensure user data is fetched/created before emitting success
      await getUserData();
      if (isClosed) return;

      await addUserData(email: email, name: name);
      if (!isClosed) emit(SignUpSuccess());
    } on AuthException catch (e) {
      log('Auth Exception during registration: ${e.toString()}');
      if (!isClosed) emit(SignUpFailure(errorMessage: e.message));
    } catch (e) {
      log('General Exception during registration: ${e.toString()}');
      if (!isClosed) emit(SignUpFailure(errorMessage: e.toString()));
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
      if (!isClosed) emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(LogoutFailure());
    }
  }

  Future<void> resetPassword(String email) async {
    if (!isClosed) emit(ResetpasswordLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      if (!isClosed) emit(ResetpasswordSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(ResetpasswordFailure());
    }
  }

  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    if (!isClosed) emit(UserDataAddedLoading());
    try {
      await client.from('users').insert({
        'id': client.auth.currentUser?.id,
        'name': name,
        'email': email,
      });
      if (!isClosed) emit(UserDataAddedSuccess());
    } catch (e) {
      log(e.toString());
      if (!isClosed) emit(UserDataAddedFailure());
    }
  }

  UserDataModel? userDataModel;

  Future<void> getUserData() async {
    if (!isClosed) emit(GetUserDataLoading());

    try {
      final data = await client
          .from('users')
          .select()
          .eq("id", client.auth.currentUser!.id)
          .limit(1);

      if (isClosed) return;

      if (data.isNotEmpty) {
        userDataModel = UserDataModel.fromJson(data.first);
        if (!isClosed) emit(GetUserDataSuccess());
      } else {
        log('User not found in Supabase');
        if (!isClosed) emit(GetUserDataFailure());
      }
    } catch (e) {
      log('Error: $e');
      if (!isClosed) emit(GetUserDataFailure());
    }
  }
}
