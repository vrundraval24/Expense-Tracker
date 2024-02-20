

import 'package:expense_tracker/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:expense_tracker/cubits/network_connection_cubit/network_connection_cubit.dart';
import 'package:expense_tracker/routes/routes.dart';
import 'package:expense_tracker/utils/category_list.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {

  // create a category list
  CategoryList.createDropDownMenu();

  // initialize home cubit
  locator.registerSingleton<HomePageCubit>(HomePageCubit());

  // Initialize network connection cubit - to check network ASAP
  locator.registerSingleton<NetworkConnectionCubit>(NetworkConnectionCubit());

  // Initialize Router
  locator.registerSingleton<Routes>(Routes());
  
}