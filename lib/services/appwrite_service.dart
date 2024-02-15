import 'package:appwrite/appwrite.dart';

import '../core/constants/constants.dart';

class AppwriteService {
  static Client? _client;
  static Databases? _database;
  static Storage? _storage;
  static Account? _account;
  // static Realtime? _realtime;

  // Instantiates a new AppWrite Client if it doesn't exist
  static Client getClient() {
    _client ??= Client()
        .setEndpoint(Constants.APPWRITE_ENDPOINT)
        .setProject(Constants.APPWRITE_PROJECT_ID)
        .setSelfSigned(status: true);
    return _client!;
  }

  // Instantiates a new Databases Instance if it doesn't exist
  static Databases getDatabases() {
    _database ??= Databases(getClient());
    return _database!;
  }

  // Instantiates a new Storage Instance if it doesn't exist
  static Storage getStorage() {
    _storage ??= Storage(getClient());
    return _storage!;
  }

  static Account getAccount(){
    _account ??= Account(getClient());
    return _account!;
  }

  // Instantiates a new Realtime Instance if it doesn't exist
  // static Realtime getRealtime() {
  //   _realtime ??= Realtime(getClient());
  //   return _realtime!;
  // }
}
