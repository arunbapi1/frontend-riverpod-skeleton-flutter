import 'dart:io';

import 'package:architecture_demo/utility/shared_preferance_utility.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void startLoading() {
    state = true;
  }

  void stopLoading() {
    state = false;
  }
}

class ExampleValueNotifier extends StateNotifier<String?> {
  final PreferencesService _preferencesService;

  ExampleValueNotifier(this._preferencesService) : super(null) {
    _loadExampleValue();
  }

  Future<void> _loadExampleValue() async {
    final exampleValue = await _preferencesService.getExampleValue();
    state = exampleValue;
  }

  Future<void> setExampleValue(String value) async {
    await _preferencesService.saveExampleValue(value);
    state = value;
  }
}

class NetworkNotifier extends StateNotifier<bool> {
  NetworkNotifier() : super(false) {
    _checkNetworkStatus();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _checkNetworkStatus();
    });
  }

  Future<void> _checkNetworkStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        state = true;
      } else {
        state = false;
      }
    } on SocketException catch (_) {
      state = false;
    }
  }
}
