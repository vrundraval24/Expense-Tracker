import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/core/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/error/failure.dart';
import '../../services/appwrite_service.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());

  final account = AppwriteService.getAccount();

  Future<void> loginWithGoogle() async {
    try {
      await account.createOAuth2Session(provider: 'google');

      emit(LoginPageSuccessState());

      // Login is successful so save user auth status as LOGGED IN in hive database
      final hiveBox = Hive.box(Constants.HIVE_BOX_NAME);
      hiveBox.put(Constants.USER_AUTH_STATUS, true);
    } catch (e) {
      log(e.toString());

      emit(
        LoginPageFailureState(
          failure: Failure(errorMessage: 'Failed to login with Google.'),
        ),
      );
    }
  }
}
