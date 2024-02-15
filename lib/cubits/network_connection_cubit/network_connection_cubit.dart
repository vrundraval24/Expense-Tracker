import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../routes/routes.dart';

part 'network_connection_state.dart';

class NetworkConnectionCubit extends Cubit<NetworkConnectionState> {
  // Initialize connectivity
  final connectivity = InternetConnection.createInstance();

  bool isDialogOpen = false;

  // print("connectivity initiated...");

  NetworkConnectionCubit() : super(NetworkConnectionInitial()) {
    // Get build context
    BuildContext? ctx =
        Routes().router.routerDelegate.navigatorKey.currentContext;

    connectivity.onStatusChange.listen((status) {
      if (status == InternetStatus.disconnected) {
        print('connection lost emitted...');

        if (ctx != null) {
          isDialogOpen = true;
          showDialog(
            barrierDismissible: false,
            context: ctx,
            builder: (context) {
              return PopScope(
                canPop: false,
                child: AlertDialog(
                  title: const Text('No Internet Connection'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          checkConnectionAgain();
                        },
                        child: const Text('Try again'))
                  ],
                ),
              );
            },
          );
        }
      } else {
        print('connection gained emitted...');

        if ((ctx != null) && isDialogOpen) {
          isDialogOpen = false;
          Navigator.pop(ctx);
        }
      }
    });
  }

  Future<void> checkConnectionAgain() async {
    // Get build context
    BuildContext? ctx =
        Routes().router.routerDelegate.navigatorKey.currentContext;


    connectivity.internetStatus.then((status) {
      print(status);

      if (status == InternetStatus.connected && isDialogOpen) {
        if (ctx != null) {
          Navigator.pop(ctx);
        }
      }
    });
  }

  Future<bool> isInternetAvailable() async {
    InternetStatus internetStatus = await connectivity.internetStatus;

    if (internetStatus == InternetStatus.connected) {
      return true;
    } else {
      return false;
    }
  }

// final _connectivity = InternetConnectionCheckerPlus();
//
// @override
// void onInit() {
//   super.onInit();
//
//   _connectivity.onStatusChange.listen((status) {
//     if (status == InternetConnectionStatus.disconnected) {
//       Get.dialog(const NoConnectionDialog(), barrierDismissible: false);
//     } else {
//       if (Get.isDialogOpen!) {
//         Get.back();
//       }
//     }
//   });
// }
//
// void tryAgain()async {
//   var status = await _connectivity.connectionStatus;
//   log(status.toString());
//   if (status == InternetConnectionStatus.connected){
//     if (Get.isDialogOpen!) {
//       Get.back();
//     }
//   }
// }
}
