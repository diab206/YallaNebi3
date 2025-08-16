import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yalla_nebi3/core/models/user_data_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial()) {
    // Listen to auth state changes (login, logout, refresh, restore session)
    client.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      // ignore: unnecessary_null_comparison
      if (session != null && session.user != null) {
        getUserData();
      } else {
        userDataModel = null;
        if (!isClosed) emit(LogoutSuccess());
      }
    });

    // immediate check when cubit is created
    _checkSessionOnStart();
  }

  final SupabaseClient client = Supabase.instance.client;
  UserDataModel? userDataModel;

  Future<void> _checkSessionOnStart() async {
    final session = client.auth.currentSession;
    // ignore: unnecessary_null_comparison
    if (session != null && session.user != null) {
      await getUserData();
    } else {
      if (!isClosed) emit(LogoutSuccess());
    }
  }

  Future<void> login({required String email, required String password}) async {
    if (!isClosed) emit(LoginLoading());
    try {
      final response = await client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      await getUserData();
      if (response.user != null && !isClosed) {
        emit(LoginSuccess());
      } else {
        if (!isClosed) emit(LoginFailure(errorMessage: 'Login failed'));
      }
    } on AuthException catch (e) {
      if (!isClosed) emit(LoginFailure(errorMessage: e.message));
    } catch (e) {
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
      await addUserData(email: email, name: name);
      await getUserData();
      if (!isClosed) emit(SignUpSuccess());
    } on AuthException catch (e) {
      if (!isClosed) emit(SignUpFailure(errorMessage: e.message));
    } catch (e) {
      if (!isClosed) emit(SignUpFailure(errorMessage: e.toString()));
    }
  }

  User? getCurrentUser() => client.auth.currentUser;

  Future<void> signOut() async {
    try {
      await client.auth.signOut();
      userDataModel = null;
      if (!isClosed) emit(LogoutSuccess());
    } catch (_) {
      if (!isClosed) emit(LogoutFailure());
    }
  }

  Future<void> resetPassword(String email) async {
    if (!isClosed) emit(ResetpasswordLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      if (!isClosed) emit(ResetpasswordSuccess());
    } catch (_) {
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
    } catch (_) {
      if (!isClosed) emit(UserDataAddedFailure());
    }
  }

  Future<void> getUserData() async {
    if (!isClosed) emit(GetUserDataLoading());
    try {
      final data = await client
          .from('users')
          .select()
          .eq("id", client.auth.currentUser!.id)
          .limit(1);
      if (data.isNotEmpty) {
        userDataModel = UserDataModel.fromJson(data.first);
        if (!isClosed) emit(GetUserDataSuccess());
      } else {
        if (!isClosed) emit(GetUserDataFailure());
      }
    } catch (_) {
      if (!isClosed) emit(GetUserDataFailure());
    }
  }
}
