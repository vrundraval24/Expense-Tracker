import 'package:appwrite/appwrite.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/services/appwrite_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/transaction_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial()) {
    print('HomePageCubit is created.');

    fetchTransactionData();
  }

  final databases = AppwriteService.getDatabases();

  Future<void> fetchTransactionData() async {

    // emit(HomePageLoadingState());

    List<TransactionModel> list = [];

    final result = await databases.listDocuments(
      databaseId: Constants.DATABASES_ID,
      collectionId: Constants.TRANSACTION_COLLECTION_ID,
    );

    result.documents.forEach((document) {
      list.insert(0, TransactionModel.fromJson(document));
    });

    print(list[0].category);

    emit(HomePageDataFetchSuccessState(listOfTransactionModels: list));
  }
}
