part of 'login_page_cubit.dart';

abstract class LoginPageState {}

class LoginPageInitial extends LoginPageState {}

class LoginPageSuccessState extends LoginPageState {}

class LoginPageFailureState extends LoginPageState {
  final Failure failure;

  LoginPageFailureState({required this.failure});
}
