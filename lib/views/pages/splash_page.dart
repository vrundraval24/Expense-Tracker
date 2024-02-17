import 'package:expense_tracker/cubits/network_connection_cubit/network_connection_cubit.dart';
import 'package:expense_tracker/cubits/splash_page_cubit/splash_page_cubit.dart';
import 'package:expense_tracker/routes/routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final splashPageCubit = BlocProvider.of<SplashPageCubit>(context);

    splashPageCubit.isUserLoggedIn();

    // Initialize Network Cubit
    // BlocProvider.of<NetworkConnectionCubit>(context);

    return BlocListener<SplashPageCubit, SplashPageState>(
      listener: (context, state) {
        if (state is SplashPageIsUserLoggedInState) {
          if (state.isUserLoggedInBoolean) {
            // User is logged in - so move to home screen
            GoRouter.of(context)
                .pushReplacementNamed(RoutesConstant.MAIN_PAGE_NAME);
          } else {
            // User is logged out - so move to login screen
            GoRouter.of(context)
                .pushReplacementNamed(RoutesConstant.LOGIN_PAGE_NAME);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Splash'),
        ),
        body: BlocBuilder<SplashPageCubit, SplashPageState>(
          builder: (context, state) {
            if (state is SplashPageErrorState) {
              return RefreshIndicator(
                onRefresh: () async {
                  await splashPageCubit.isUserLoggedIn();
                },
                child: ListView(children:  [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const Center(
                    child: Text('Something went wrong. Please refresh.'),
                  ),
                ]),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
