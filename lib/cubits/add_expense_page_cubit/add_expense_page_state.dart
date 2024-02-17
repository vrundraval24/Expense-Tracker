part of 'add_expense_page_cubit.dart';

abstract class AddExpensePageState {}

class AddExpensePageInitial extends AddExpensePageState {
  final Set<String> selectedType;

  AddExpensePageInitial({required this.selectedType});
}
