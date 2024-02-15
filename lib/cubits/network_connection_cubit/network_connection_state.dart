part of 'network_connection_cubit.dart';

abstract class NetworkConnectionState {}

class NetworkConnectionInitial extends NetworkConnectionState {}

class NetworkConnectionLost extends NetworkConnectionState {}

class NetworkConnectionGained extends NetworkConnectionState {}
