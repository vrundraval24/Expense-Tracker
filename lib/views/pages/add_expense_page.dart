import 'package:expense_tracker/cubits/add_expense_page_cubit/add_expense_page_cubit.dart';
import 'package:expense_tracker/utils/category_list.dart';
import 'package:expense_tracker/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../core/enums/enums.dart';
import '../../cubits/home_page_cubit/home_page_cubit.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final addExpensePageCubit = BlocProvider.of<AddExpensePageCubit>(context);
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                onPressed: () async {
                  if (addExpensePageCubit.addExpenseFormKey.currentState!
                      .validate()) {

                    Navigator.pop(context);

                    await addExpensePageCubit.addTransactionToDatabase();
                    homePageCubit.fetchTransactionData();

                  }
                },
                icon: const Icon(Icons.check),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.maxFinite,
                ),
                StatefulBuilder(
                  builder: (context, setState) {
                    return SegmentedButton(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 40),
                        ),
                      ),
                      segments: const [
                        ButtonSegment(
                          value: TransactionType.EXPENSE,
                          label: Text('Expense'),
                          // icon: Icon(Icons.upload_rounded),
                        ),
                        ButtonSegment(
                          value: TransactionType.INCOME,
                          label: Text('Income'),
                          // icon: Icon(Icons.download_rounded),
                        ),
                      ],
                      selected: {addExpensePageCubit.selectedType},
                      onSelectionChanged: (setOfObjects) {
                        // first element of set because there is only one element
                        addExpensePageCubit.selectedType = setOfObjects.first;
                        setState(() {});
                      },
                    );
                  },
                ),
                Form(
                  key: addExpensePageCubit.addExpenseFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: addExpensePageCubit.amountController,
                        maxLength: 5,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Enter amount',
                            prefixIcon: Icon(Icons.currency_rupee_rounded)),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null) {
                            return Validations.notNullValidation(value.trim());
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s|-|,|\.'))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: addExpensePageCubit.titleController,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          counterText: '',
                          hintText: 'Enter title or items name',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value != null) {
                            return Validations.notNullValidation(value.trim());
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButtonFormField(
                            validator: (value) {
                              if ((value == null) ||
                                  (value.toString().trim() == '')) {
                                return 'Required field.';
                              }
                              return null;
                            },
                            focusColor: Colors.transparent,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                              ),
                              hintText: 'Select category',

                              // TODO: Icon alignment and perfection
                              prefixIcon: addExpensePageCubit.isItemSelected
                                  ? null
                                  : Icon(Icons.format_list_bulleted_rounded),
                            ),
                            items: CategoryList.dropdownMenuEntryList,
                            onChanged: (value) {
                              print('value: $value');
                              addExpensePageCubit.categoryController.text =
                                  value.toString();

                              addExpensePageCubit.isItemSelected = true;
                              setState(() {});
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value != null) {
                            return Validations.notNullValidation(value.trim());
                          }
                          return null;
                        },
                        canRequestFocus: false,
                        controller: addExpensePageCubit.dateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: 'Select date',
                          prefixIcon: Icon(Icons.calendar_month_rounded),
                        ),
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: addExpensePageCubit.selectedDate,
                            firstDate: DateTime.now().subtract(
                              const Duration(days: 365),
                            ),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );

                          if (newDate != null) {
                            addExpensePageCubit.dateController.text =
                                DateFormat('dd/MM/yy').format(newDate);
                            addExpensePageCubit.selectedDate = newDate;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
