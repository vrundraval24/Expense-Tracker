import 'package:expense_tracker/data/category_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

part 'add_expense_page_state.dart';

class AddExpensePageCubit extends Cubit<AddExpensePageState> {
  AddExpensePageCubit()
      : super(
          AddExpensePageInitial(
            selectedType: {'expense'},
          ),
        ) {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    createDropDownMenu();
  }

  final titleController = TextEditingController();
  final dateController = TextEditingController();

  final GlobalKey<FormState> addExpenseFormKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Icon categoryIcon = Icon(FontAwesomeIcons.list);

  void changeSegment(Set<String> type) {
    emit(AddExpensePageInitial(selectedType: type));
  }

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

  // final List<DropdownMenuEntry<CategoryModel>> dropdownMenuEntryList = [];

  final List<DropdownMenuItem<Object>> dropdownMenuEntryList = [];

  bool isItemSelected = false;

  void createDropDownMenu() {
    print("create drop down menu called");

    for (var category in CategoryData.listOfCategories) {
      dropdownMenuEntryList.add(
        DropdownMenuItem(
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Icon(
                category.icon.icon,
                size: 18,
                // color: category.color,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                category.name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          value: category,
        ),
      );
    }
  }
}
