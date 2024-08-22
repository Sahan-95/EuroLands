import 'package:countries_list/data/model/country_model.dart';
import 'package:countries_list/data/repository/rest_client.dart';
import 'package:countries_list/domain/providers/country_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:get_it/get_it.dart';

import 'country_provider_test.mocks.dart';

// Generate a MockRestClient class
@GenerateMocks([RestClient])
void main() {
  late CountryProvider countryProvider;
  late MockRestClient mockRestClient;

  setUp(() {
    // Initialize the GetIt instance
    mockRestClient = MockRestClient();
    GetIt.I.registerSingleton<RestClient>(mockRestClient);
    countryProvider = CountryProvider(restClient: mockRestClient);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('Fetch countries and process correctly', () async {
    //.........Arrange.............//
    // Mock data for testing
    final mockCountries = [
      Country(
        nameDetails: NameDetails(
            common: 'Germany', official: 'Federal Republic of Germany'),
        capital: ['Berlin'],
        flags: Flags(
            png: 'https://example.com/germany.png',
            svg: 'https://flagcdn.com/de.svg',
            alt:
                'The flag of Germany is composed of three equal horizontal bands of black, red and gold.'),
        region: 'Europe',
        population: 83783942,
        languages: {'deu': 'German'},
      ),
      Country(
        nameDetails: NameDetails(common: 'France', official: 'French Republic'),
        capital: ['Paris'],
        flags: Flags(
            png: 'https://example.com/france.png',
            svg: 'https://flagcdn.com/fr.svg',
            alt:
                'The flag of France is composed of three equal vertical bands of blue, white and red.'),
        region: 'Europe',
        population: 65273511,
        languages: {'fra': 'French'},
      ),
    ];

    // Set up the mock API response
    when(mockRestClient.getEuropeanCountries(any))
        .thenAnswer((_) async => mockCountries);

    //................Act...................//
    // Perform the API fetch
    await countryProvider.fetchCountries();

    //...............Assert.................//
    // Verify that the countries list in the provider is correctly populated
    expect(countryProvider.countries.length, 2);
    expect(countryProvider.countries[0].nameDetails.common, 'Germany');
    expect(countryProvider.countries[1].nameDetails.common, 'France');
  });

  test('Handles API errors gracefully', () async {
    // Set up the mock API response to throw an error
    when(mockRestClient.getEuropeanCountries(any))
        .thenThrow(Exception('Network error'));

    // Perform the API fetch
    await countryProvider.fetchCountries();

    // Verify that an error message is set
    expect(countryProvider.errorMessage, 'Failed to load countries');
    expect(countryProvider.countries.isEmpty, true);
  });
}
