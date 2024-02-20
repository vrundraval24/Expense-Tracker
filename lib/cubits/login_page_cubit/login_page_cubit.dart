import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/error/failure.dart';
import '../../services/appwrite_sdk_services.dart';
import '../../services/appwrite_service.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());

  final account = AppwriteService.getAccount();
  final databases = AppwriteSdkService.getDatabases();

  Future<void> createCollection() async {
    try {
      // After login is completed. Fetch user info
      final user = await AppwriteService.getUser();

      final _collectionId = user.$id;

      await databases.createCollection(
        databaseId: Constants.DATABASES_ID,
        collectionId: _collectionId,
        name: user.email,
        permissions: [
          Permission.read(Role.any()),
          Permission.write(Role.any()),
          Permission.create(Role.any()),
          Permission.delete(Role.any()),
          Permission.update(Role.any()),
        ],
      );

      await databases.createEnumAttribute(
        databaseId: Constants.DATABASES_ID,
        collectionId: _collectionId,
        key: 'Type',
        xrequired: true,
        elements: ['expense', 'income'],
      );

      await databases.createStringAttribute(
        databaseId: Constants.DATABASES_ID,
        collectionId: _collectionId,
        key: 'Title',
        size: 100,
        xrequired: true,
      );

      await databases.createEnumAttribute(
        databaseId: Constants.DATABASES_ID,
        collectionId: _collectionId,
        key: 'Category',
        xrequired: true,
        elements: [
          'food',
          'travel',
          'healthcare',
          'clothes',
          'entertainment',
        ],
      );

      await databases.createStringAttribute(
        databaseId: Constants.DATABASES_ID,
        collectionId: _collectionId,
        key: 'Date',
        size: 20,
        xrequired: true,
      );

      await databases.createIntegerAttribute(
        databaseId: Constants.DATABASES_ID,
        collectionId: _collectionId,
        key: 'Amount',
        min: 0,
        max: 99999,
        xrequired: true,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      // Login user with google
      await account.createOAuth2Session(provider: 'google');

      createCollection();

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
