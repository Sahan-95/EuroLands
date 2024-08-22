import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:countries_list/presentation/utils/extensions/colors_extension.dart';

import '/data/model/country_model.dart';
import '../utils/colors/color_coding.dart';
import '../utils/responsive/screen_sizes.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    double screenHeight = displayHeight(context);
    double screenWidth = displayWidth(context);

    const TextStyle defaultTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    TextStyle titleTextStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: titleFontColor.toColor());

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/images/europian.jpg',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.13),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: country.flags.png,
                        height: screenHeight * 0.25,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: appBarBackgroundColor.toColor(),
                          strokeWidth: 2,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Text(country.nameDetails.common.toUpperCase(),
                          style: titleTextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.1, top: screenWidth * 0.02),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Capital: ${country.capital.join(',')}',
                                style: defaultTextStyle),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.01),
                              child: Text('Population: ${country.population}',
                                  style: defaultTextStyle),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.01),
                              child: Text('Region: ${country.region}',
                                  style: defaultTextStyle),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.03),
                              child: Text('Languages:', style: titleTextStyle),
                            ),
                            for (var language in country.languages.values)
                              Text('- $language', style: defaultTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
