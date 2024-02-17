

import 'package:expense_tracker/cubits/network_connection_cubit/network_connection_cubit.dart';
import 'package:expense_tracker/routes/routes.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {

  // Initialize network connection cubit - to check network ASAP
  locator.registerSingleton<NetworkConnectionCubit>(NetworkConnectionCubit());

  // Initialize Router
  locator.registerSingleton<Routes>(Routes());
  
}