import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;
}

class InternetConnectionImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  InternetConnectionImpl(this.internetConnection);
  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}
