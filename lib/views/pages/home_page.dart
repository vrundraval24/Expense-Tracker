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
        if (state is HomePageLoadingState) {
          homePageCubit.fetchTransactionData();

          print('state is HomePageLoadingState');

          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomePageDataFetchSuccessState) {
          print('state is HomePageDataFetchSuccessState');

          if (state.listOfTransactionModels.length > 0) {}

          return RefreshIndicator(
            onRefresh: () async {
              await homePageCubit.fetchTransactionData();
            },
            child: (state.listOfTransactionModels.length == 0)
                ? ListView(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        alignment: Alignment.center,
                          child: Text('Empty', style: TextStyle(
                            fontSize: 24,
                            color: Colors.black45
                          ),),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: state.listOfTransactionModels.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          child: FaIcon(
                            CategoryData
                                .categoryKeyValuePairs[state
                                    .listOfTransactionModels[index]
                                    .category]['icon']
                                .icon,
                            color: Colors.white,
                            size: 20,
                          ),
                          backgroundColor: CategoryData.categoryKeyValuePairs[
                                  state.listOfTransactionModels[index].category]
                              ['color'],
                        ),
                        title: Text(
                          state.listOfTransactionModels[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                            '${state.listOfTransactionModels[index].category}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹ ${state.listOfTransactionModels[index].amount}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: (state.listOfTransactionModels[index]
                                              .type ==
                                          TransactionType.EXPENSE.name
                                              .toLowerCase())
                                      ? Colors.red
                                      : Colors.green),
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

        if (state is HomePageDataFetchFailureState) {
          print('state is HomePageDataFetchFailureState');

          return RefreshIndicator(
            onRefresh: () async {
              await homePageCubit.fetchTransactionData();
            },
            child: ListView(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              const Center(
                child: Text('Something went wrong. Please refresh.'),
              ),
            ]),
          );
        }

        return SizedBox();
      },
    );
  }
}
