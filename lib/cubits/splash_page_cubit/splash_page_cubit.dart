import 'dart:async';
import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../services/appwrite_service.dart';

part 'splash_page_state.dart';

class SplashPageCubit extends Cubit<SplashPageState> {
  SplashPageCubit() : super(SplashPageLoadingState()) {}

  final account = AppwriteService.getAccount();

  Future<void> isUserLoggedIn() async {
    try {
      final hiveBox = Hive.box(Constants.HIVE_BOX_NAME);

      final result = await hiveBox.get(Constants.USER_AUTH_STATUS);

      print(result);

      if (result == null) {
        print('logged out state emitted...');
        emit(SplashPageIsUserLoggedInState(isUserLoggedInBoolean: false));
      } else if (result == true) {
        emit(SplashPageIsUserLoggedInState(isUserLoggedInBoolean: true));
      }

      // User user = await account.get();
      //
      // if (user.$id != '') {
      //   // user exists or we can say user is logged in
      //   emit(SplashPageIsUserLoggedInState(isUserLoggedInBoolean: true));
      // } else {
      //   // user is logged out
      //   emit(SplashPageIsUserLoggedInState(isUserLoggedInBoolean: false));
      // }
    } catch (e) {
      emit(SplashPageErrorState());
      log(e.toString());
    }
  }
}
