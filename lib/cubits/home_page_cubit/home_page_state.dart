part of 'home_page_cubit.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoadingState extends HomePageState {}

class HomePageDataFetchSuccessState extends HomePageState {
  final List<TransactionModel> listOfTransactionModels;

  HomePageDataFetchSuccessState({required this.listOfTransactionModels});

}

class HomePageDataFetchFailureState extends HomePageState {}
