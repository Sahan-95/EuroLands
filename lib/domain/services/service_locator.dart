import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '/data/repository/rest_client.dart';

// Initialize the get it
final GetIt getIt = GetIt.instance;

// Dependency injection for creating objects
void setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<RestClient>(RestClient(getIt<Dio>()));
}
