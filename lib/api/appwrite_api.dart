import 'dart:developer';
import 'dart:io';

import '../services/appwrite_service.dart';

class AppwriteApi {
  final account = AppwriteService.getAccount();

  // Google login
  Future<void> loginWithGoogle() async {
    try {
      await account.createOAuth2Session(provider: 'google');
    }catch (e) {
      log(e.toString());
    }
  }

  // Is user logged in with google or not
  Future<bool> isUserLoggedIn() async {
    try {
      await account.get();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
