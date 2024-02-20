import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/services/appwrite_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/transaction_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial()) {
    print('HomePageCubit is created.');

    emit(HomePageLoadingState());
  }

  final databases = AppwriteService.getDatabases();

  Future<void> fetchTransactionData() async {


    try{

      // Initialize Appwrite User
      final user = await AppwriteService.getUser();

      List<TransactionModel> list = [];

      final result = await databases.listDocuments(
        databaseId: Constants.DATABASES_ID,
        collectionId: user.$id,
      );

      result.documents.forEach((document) {
        list.insert(0, TransactionModel.fromJson(document));
      });

      emit(HomePageDataFetchSuccessState(listOfTransactionModels: list));


    }catch (e){
      log(e.toString());
      emit(HomePageDataFetchFailureState());
    }


  }
}
