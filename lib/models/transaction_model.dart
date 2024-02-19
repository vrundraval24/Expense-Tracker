import 'package:appwrite/models.dart';

class TransactionModel {
  final String type;
  final String title;
  final String category;
  final String date;
  final int amount;

  TransactionModel({
    required this.type,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
  });

  factory TransactionModel.fromJson(Document document) {
    return TransactionModel(
      type: document.data['Type'],
      title: document.data['Title'],
      category: document.data['Category'],
      date: document.data['Date'],
      amount: document.data['Amount'],
    );
  }

  static Map<String, dynamic> toMap(TransactionModel model) {
    return {
      "Type": model.type,
      "Title": model.title,
      "Category": model.category,
      "Date": model.date,
      "Amount": model.amount,
    };
  }
}
