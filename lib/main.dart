import 'package:countries_list/data/repository/rest_client.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'domain/services/service_locator.dart';
import 'presentation/screens/country_list_screen.dart';
import 'domain/providers/country_provider.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());

  //...... this is for Responsive check.....//

  // runApp(
  //   DevicePreview(
  //     builder: (context) => MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CountryProvider(restClient: GetIt.I<RestClient>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // ....... This is for responsive check .........//
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,

        title: 'European Countries',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CountryListScreen(),
      ),
    );
  }
}
