import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

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
      await client.auth.signInWithPassword(password: password, email: email);
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginFailure(errorMessage: e.message));
    } catch (e) {
      emit(LoginFailure(errorMessage: (e.toString())));
    }
  }
}
