import 'package:expense_tracker/cubits/main_page_cubit/main_page_cubit.dart';
import 'package:expense_tracker/routes/routes_constant.dart';
import 'package:expense_tracker/views/pages/add_expense_page.dart';
import 'package:expense_tracker/views/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'chart_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainPageCubit = BlocProvider.of<MainPageCubit>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: BlocBuilder<MainPageCubit, int>(
        builder: (context, index) {
          return pagesList[index];
        },
      ),
      bottomNavigationBar: BlocBuilder<MainPageCubit, int>(
        builder: (context, index) {
          return NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (indexValue) {
              mainPageCubit.changeNavigationIndex(indexValue);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.stacked_bar_chart_rounded),
                label: 'Chart',
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          GoRouter.of(context).pushNamed(RoutesConstant.ADD_EXPENSE_PAGE_NAME);
        },
        label: const Text('Add Expense'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

final pagesList = [const HomePage(), const ChartPage()];
