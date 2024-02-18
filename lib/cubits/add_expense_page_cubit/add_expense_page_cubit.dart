import 'package:appwrite/appwrite.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/core/enums/enums.dart';
import 'package:expense_tracker/services/appwrite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'add_expense_page_state.dart';

class AddExpensePageCubit extends Cubit<AddExpensePageState> {
  AddExpensePageCubit() : super(AddExpensePageInitial()) {
    // Initialization
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
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
    if (addExpenseFormKey.currentState!.validate()) {

      print(categoryController.text);

      final result = await databases.createDocument(
        databaseId: Constants.DATABASES_ID,
        collectionId: Constants.TRANSACTION_COLLECTION_ID,
        documentId: ID.unique(),
        data: {
          "Type": selectedType.name.toLowerCase(),
          "Title": titleController.text,
          "Category": categoryController.text.toLowerCase(),
          "Date": dateController.text,
          "Amount": int.parse(amountController.text),
        },
      );

      print(result);
    }

  }
}
