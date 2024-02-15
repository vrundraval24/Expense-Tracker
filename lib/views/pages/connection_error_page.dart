import 'package:expense_tracker/cubits/network_connection_cubit/network_connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ConnectionErrorPage extends StatelessWidget {
  const ConnectionErrorPage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<NetworkConnectionCubit, NetworkConnectionState>(
  //     builder: (context, state) {
  //
  //       if(state is NetworkConnectionLost){
  //         return Scaffold(
  //           appBar: AppBar(
  //             title: const Text('Connection Error'),
  //           ),
  //           body: const Center(
  //             child: Text(
  //                 'Connection Lost'
  //             ),
  //           ),
  //         );
  //       }
  //
  //       if (state is NetworkConnectionGained){
  //         GoRouter.of(context).pop();
  //       }
  //
  //       return const Text('Checking connection...');
  //
  //
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkConnectionCubit, NetworkConnectionState>(
      builder: (context, state) {

        if(state is NetworkConnectionLost){
          return Scaffold(
            appBar: AppBar(
              title: const Text('Connection Error'),
            ),
            body: const Center(
              child: Text(
                  'Connection Lost'
              ),
            ),
          );
        }

        if (state is NetworkConnectionGained){
          GoRouter.of(context).pop();
        }

        return const Text('Checking connection...');


      },
    );
  }
}
