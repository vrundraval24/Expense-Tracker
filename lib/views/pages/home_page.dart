import 'package:expense_tracker/core/enums/enums.dart';
import 'package:expense_tracker/cubits/home_page_cubit/home_page_cubit.dart';
import 'package:expense_tracker/data/category_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);

    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        if (state is HomePageDataFetchSuccessState) {
          return RefreshIndicator(
            onRefresh: () async {
              await homePageCubit.fetchTransactionData();
            },
            child: ListView.builder(
              itemCount: state.listOfTransactionModels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    child: FaIcon(
                      CategoryData
                          .categoryKeyValuePairs[state
                              .listOfTransactionModels[index].category]['icon']
                          .icon,
                      color: Colors.white,
                      size: 20,
                    ),
                    backgroundColor: CategoryData.categoryKeyValuePairs[
                        state.listOfTransactionModels[index].category]['color'],
                  ),
                  title: Text(
                    state.listOfTransactionModels[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle:
                      Text('${state.listOfTransactionModels[index].category}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹ ${state.listOfTransactionModels[index].amount}',
                        style: TextStyle(
                          fontSize: 14,
                          color: (state.listOfTransactionModels[index].type == TransactionType.EXPENSE.name.toLowerCase())
                          ? Colors.red
                              : Colors.green
                        ),
                      ),
                      Text(
                        state.listOfTransactionModels[index].date,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
