import 'package:expense_tracker/data/category_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

part 'add_expense_page_state.dart';

class AddExpensePageCubit extends Cubit<AddExpensePageState> {
  AddExpensePageCubit() : super(AddExpensePageInitial()) {

    // Initialization
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  bool isItemSelected = false;
  DateTime selectedDate = DateTime.now();
  Set<String> selectedType = {'expense'};

  final GlobalKey<FormState> addExpenseFormKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final titleController = TextEditingController();
  final dateController = TextEditingController();

  // void changeSegment(Set<String> type) {
  //   emit(AddExpensePageInitial(selectedType: type));
  // }

  // final List<DropdownMenuEntry<CategoryModel>> dropdownMenuEntryList = [];

  // void createDropDownMenu() {
  //
  //   print("create drop down menu called");
  //
  //   for (var category in CategoryData.listOfCategories) {
  //     dropdownMenuEntryList.add(
  //       DropdownMenuEntry(
  //         label: category.name,
  //         value: category,
  //         leadingIcon: category.icon,
  //       ),
  //     );
  //   }
  // }
}
