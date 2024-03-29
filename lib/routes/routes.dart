import 'package:expense_tracker/cubits/add_expense_page_cubit/add_expense_page_cubit.dart';
import 'package:expense_tracker/routes/routes_constant.dart';
import 'package:expense_tracker/views/pages/add_expense_page.dart';
import 'package:expense_tracker/views/pages/home_page.dart';
import 'package:expense_tracker/views/pages/login_page.dart';
import 'package:expense_tracker/views/pages/main_page.dart';
import 'package:expense_tracker/views/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class Routes {
  final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: RoutesConstant.SPLASH_PAGE_NAME,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SplashPage(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.LOGIN_PAGE_NAME,
        path: '/loginPage',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginPage(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.MAIN_PAGE_NAME,
        path: '/mainPage',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: MainPage(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.HOME_PAGE_NAME,
        path: '/homePage',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomePage(),
          );
        },
      ),
      GoRoute(
        name: RoutesConstant.ADD_EXPENSE_PAGE_NAME,
        path: '/addExpensePage',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: BlocProvider(
              create: (context) => AddExpensePageCubit(),
              child: AddExpensePage(),
            ),
          );
        },
      ),
    ],
  );
}
