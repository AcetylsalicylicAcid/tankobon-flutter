import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityState extends ChangeNotifier {
  ConnectivityResult? _connectivityStatus;
  ConnectivityResult? get connectivityStatus => _connectivityStatus;

  void setConnectivityStatus(ConnectivityResult? value) {
    _connectivityStatus = value;
    notifyListeners();
  }
}
