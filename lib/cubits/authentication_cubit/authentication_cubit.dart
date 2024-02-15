import 'dart:developer';

import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/services/appwrite_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());


  final account = AppwriteService.getAccount();

  Future<void> loginWithGoogle() async {
    try {

      await account.createOAuth2Session(provider: 'google');

      emit(AuthenticationSuccessState());
    } catch (e) {
      log(e.toString());

      emit(
        AuthenticationFailureState(
          failure: Failure(errorMessage: 'Failed to login with Google.'),
        ),
      );
    }
  }

  Future<void> isUserLoggedIn() async {
    try {

      await account.get();

      // return true;

      emit(AuthenticationSuccessState());
    }catch (e) {
      log(e.toString());
      emit(AuthenticationInitial());
      // return false;
    }
  }

  // Future<void> moveToLoginPage() async {
  //   emit(AuthenticationInitial());
  // }
}
