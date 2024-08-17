import 'dart:io';
import 'package:architecture_demo/provider/provider_details.dart';
import 'package:architecture_demo/service/service.dart';
import 'package:architecture_demo/model/user_model.dart';
import 'package:architecture_demo/utility/shared_preferance_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = FutureProvider<List<Data>>((ref) async {
  return ref.watch(userProvider).getUsers();
});

final networkProvider = StateNotifierProvider<NetworkNotifier, bool>((ref) {
  return NetworkNotifier();
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});

final selectedUserProvider = StateProvider<Data?>((ref) => null);

final exampleValueProvider =
    StateNotifierProvider<ExampleValueNotifier, String?>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return ExampleValueNotifier(preferencesService);
});

final alertMessageProvider = StateProvider<String?>((ref) => null);

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService();
});

final authProvider = StateProvider<bool>((ref) => false);
