import 'package:expense_tracker/core/enums/enums.dart';

class TransactionModel {
  final TransactionType type;
  final int amount;
  final String title;
  final Category category;
  final String date;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.title,
    required this.category,
    required this.date,
  });
}
