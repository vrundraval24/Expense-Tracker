import 'package:expense_tracker/cubits/login_page_cubit/login_page_cubit.dart';
import 'package:expense_tracker/cubits/main_page_cubit/main_page_cubit.dart';
import 'package:expense_tracker/cubits/network_connection_cubit/network_connection_cubit.dart';
import 'package:expense_tracker/cubits/splash_page_cubit/splash_page_cubit.dart';
import 'package:expense_tracker/injection_container.dart';
import 'package:expense_tracker/routes/routes.dart';
import 'package:expense_tracker/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/constants/constants.dart';
import 'cubits/add_expense_page_cubit/add_expense_page_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive initialization
  await Hive.initFlutter();

  // Open the hive box
  await Hive.openBox(Constants.HIVE_BOX_NAME);

  // Dependency injection
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginPageCubit(),
        ),
        BlocProvider(
          create: (context) => NetworkConnectionCubit(),
        ),
        BlocProvider(
          create: (context) => SplashPageCubit(),
        ),
        BlocProvider(
          create: (context) => MainPageCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: LightTheme.lightTheme,
        routerConfig: locator<Routes>().router,
      ),
    );
  }
}
