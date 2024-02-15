import 'package:expense_tracker/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:expense_tracker/cubits/login_page_cubit/login_page_cubit.dart';
import 'package:expense_tracker/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../routes/routes_constant.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginPageCubit = BlocProvider.of<LoginPageCubit>(context);

    return BlocListener<LoginPageCubit, LoginPageState>(
      listener: (context, state) {
        if (state is LoginPageFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.errorMessage),
              backgroundColor: Colors.redAccent,
            ),
          );
        }

        if (state is LoginPageSuccessState) {
          GoRouter.of(context).goNamed(RoutesConstant.MAIN_PAGE_NAME);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await loginPageCubit.loginWithGoogle();
            },
            child: const Text('Google Login'),
          ),
        ),
      ),
    );
  }
}
