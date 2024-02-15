part of 'splash_page_cubit.dart';

abstract class SplashPageState {}

class SplashPageLoadingState extends SplashPageState {}

class SplashPageIsUserLoggedInState extends SplashPageState {
  final bool isUserLoggedInBoolean;

  SplashPageIsUserLoggedInState({required this.isUserLoggedInBoolean});
}

class SplashPageErrorState extends SplashPageState {}
