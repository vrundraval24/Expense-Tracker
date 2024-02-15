

import 'package:expense_tracker/cubits/network_connection_cubit/network_connection_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  
  locator.registerLazySingleton<NetworkConnectionCubit>(() => NetworkConnectionCubit());
  
}