import 'package:appwrite/appwrite.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/core/enums/enums.dart';
import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/services/appwrite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../home_page_cubit/home_page_cubit.dart';

part 'add_expense_page_state.dart';

class AddExpensePageCubit extends Cubit<AddExpensePageState> {
  AddExpensePageCubit() : super(AddExpensePageInitial()) {
    // Initialization
    dateController.text = DateFormat('dd/MM/yy').format(DateTime.now());
  }

  bool isItemSelected = false;
  DateTime selectedDate = DateTime.now();
  TransactionType selectedType = TransactionType.EXPENSE;

  final GlobalKey<FormState> addExpenseFormKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();

  final databases = AppwriteService.getDatabases();


  // add transaction to database
  Future<void> addTransactionToDatabase() async {
    final Map<String, dynamic> map = TransactionModel.toMap(
      TransactionModel(
        type: selectedType.name.toLowerCase(),
        title: titleController.text,
        category: categoryController.text.toLowerCase(),
        date: dateController.text,
        amount: int.parse(amountController.text),
      ),
    );

    final result = await databases.createDocument(
      databaseId: Constants.DATABASES_ID,
      collectionId: Constants.TRANSACTION_COLLECTION_ID,
      documentId: ID.unique(),
      data: map,
    );

    print(result);
  }
}
