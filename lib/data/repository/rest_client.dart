import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/country_model.dart';

part 'rest_client.g.dart';

// initiate base Url
@RestApi(baseUrl: "https://restcountries.com/v3.1/")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET("region/europe")
  Future<List<Country>> getEuropeanCountries(
    @Query("fields") String fields,
  );
}
