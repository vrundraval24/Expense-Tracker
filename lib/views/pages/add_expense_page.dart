import 'package:expense_tracker/cubits/add_expense_page_cubit/add_expense_page_cubit.dart';
import 'package:expense_tracker/data/category_data.dart';
import 'package:expense_tracker/models/category_model.dart';
import 'package:expense_tracker/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    final addExpensePageCubit = BlocProvider.of<AddExpensePageCubit>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        addExpensePageCubit.isItemSelected = false;
        Navigator.pop(context);
        // addExpensePageCubit.categoryIcon = Icon(FontAwesomeIcons.list);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () {
                    addExpensePageCubit.addExpenseFormKey.currentState
                        ?.validate();
                  },
                  icon: const Icon(Icons.check),
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.maxFinite,
                ),
                BlocBuilder<AddExpensePageCubit, AddExpensePageState>(
                  builder: (context, state) {
                    if (state is AddExpensePageInitial) {
                      return SegmentedButton(
                        showSelectedIcon: false,
                        style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 40))),
                        segments: const [
                          ButtonSegment(
                            value: 'expense',
                            label: Text('Expense'),
                            // icon: Icon(Icons.upload_rounded),
                          ),
                          ButtonSegment(
                            value: 'income',
                            label: Text('Income'),
                            // icon: Icon(Icons.download_rounded),
                          ),
                        ],
                        selected: state.selectedType,
                        onSelectionChanged: (setOfStrings) {
                          addExpensePageCubit.changeSegment(setOfStrings);
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
                Form(
                  key: addExpensePageCubit.addExpenseFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
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
                      // StatefulBuilder(
                      //   builder: (context, setState) {
                      //     return DropdownMenu(
                      //       dropdownMenuEntries:
                      //           addExpensePageCubit.dropdownMenuEntryList,
                      //       hintText: 'Select category',
                      //       // errorText: 'Required field',
                      //       expandedInsets: EdgeInsets.zero,
                      //       leadingIcon: Icon(
                      //         addExpensePageCubit.categoryIcon.icon,
                      //         size: 18,
                      //       ),
                      //       // enableFilter: true,
                      //       // requestFocusOnTap: true,
                      //
                      //       onSelected: (value) {
                      //         addExpensePageCubit.categoryIcon = value!.icon;
                      //         setState(
                      //           () {},
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButtonFormField(
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
                            items: addExpensePageCubit.dropdownMenuEntryList,
                            onChanged: (value) {
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
                                DateFormat('dd/MM/yyyy').format(newDate);
                            addExpensePageCubit.selectedDate = newDate;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
