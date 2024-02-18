import 'package:expense_tracker/core/enums/enums.dart';

class TransactionModel {
  final TransactionType type;
  final String title;
  final Category category;
  final String date;
  final int amount;

  TransactionModel({
    required this.type,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  });
}
