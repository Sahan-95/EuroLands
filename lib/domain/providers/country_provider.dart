// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '/data/repository/rest_client.dart';
import '/data/model/country_model.dart';
import '/presentation/utils/enums/sort_criteria_enum.dart';

class CountryProvider with ChangeNotifier {
  final RestClient _restClient;
  List<Country> _countries = [];
  List<Country> get countries => _countries;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  SortCriteria _sortCriteria = SortCriteria.name;
  SortCriteria get sortCriteria => _sortCriteria;

  CountryProvider({required RestClient restClient}) : _restClient = restClient {
    print('CountryProvider initialized');
    fetchCountries();
  }

  void setSortCriteria(SortCriteria criteria) {
    _sortCriteria = criteria;
    _sortCountries();
    notifyListeners();
  }

  Future<void> fetchCountries() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch data from the API
      final response = await GetIt.I<RestClient>().getEuropeanCountries(
          "name,capital,flags,region,languages,population");

      // Directly assign the response
      _countries = response;

      // Sort the countries when after assign response to _country list
      _sortCountries();
    } catch (e) {
      print('Error: $e');
      _errorMessage = "Failed to load countries";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// Sort countries based on name, capital and population
  void _sortCountries() {
    _countries.sort((a, b) {
      switch (_sortCriteria) {
        case SortCriteria.name:
          return a.nameDetails.common.compareTo(b.nameDetails.common);
        case SortCriteria.capital:
          // Since capital is a List , Sorting by the first capital if there are multiple values
          return a.capital.isNotEmpty && b.capital.isNotEmpty
              ? a.capital.first.compareTo(b.capital.first)
              : 0;
        case SortCriteria.population:
          return b.population.compareTo(a.population);
        default:
          return 0;
      }
    });
  }
}
