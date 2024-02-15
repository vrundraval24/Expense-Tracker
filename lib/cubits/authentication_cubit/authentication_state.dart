part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccessState extends AuthenticationState {
  // final User appwriteUser;
  //
  // AuthenticationSuccessState({required this.appwriteUser});
}

class AuthenticationFailureState extends AuthenticationState {
  final Failure failure;

  AuthenticationFailureState({required this.failure});
}
