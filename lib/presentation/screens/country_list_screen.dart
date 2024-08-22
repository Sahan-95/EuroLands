import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:countries_list/presentation/utils/extensions/colors_extension.dart';

import 'country_details_screen.dart';
import '/domain/providers/country_provider.dart';
import '../utils/colors/color_coding.dart';
import '../utils/enums/sort_criteria_enum.dart';
import '../utils/responsive/screen_sizes.dart';

class CountryListScreen extends StatelessWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = displayWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'European Countries',
          style: TextStyle(color: whiteColor.toColor()),
        ),
        backgroundColor: appBarBackgroundColor.toColor(),
        actions: [
          PopupMenuButton<SortCriteria>(
            icon: Icon(Icons.more_vert, color: whiteColor.toColor()),
            onSelected: (criteria) {
              Provider.of<CountryProvider>(context, listen: false)
                  .setSortCriteria(criteria);
            },
            // Item builder for criteria options
            itemBuilder: (context) => <PopupMenuEntry<SortCriteria>>[
              const PopupMenuItem(
                value: SortCriteria.name,
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: SortCriteria.capital,
                child: Text('Sort by Capital'),
              ),
              const PopupMenuItem(
                value: SortCriteria.population,
                child: Text('Sort by Population'),
              ),
            ],
          )
        ],
      ),
      body: Consumer<CountryProvider>(
        builder: (context, provider, child) {
          // Loading
          if (provider.isLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: appBarBackgroundColor.toColor(),
            ));
          }

          // Error
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          return ListView.separated(
            itemCount: provider.countries.length,
            separatorBuilder: (context, index) => Divider(
              color: dividerColor.toColor(),
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              final country = provider.countries[index];
              return ListTile(
                // Load the image from fetch data
                leading: CachedNetworkImage(
                  imageUrl: country.flags.png,
                  width: screenWidth * 0.12,
                  placeholder: (context, url) => CircularProgressIndicator(
                    color: appBarBackgroundColor.toColor(),
                    strokeWidth: 2,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                title: Text(
                  country.nameDetails.common,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Capital: ${country.capital.isNotEmpty ? country.capital.first : 'N/A'}',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  // Navigation to the details screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CountryDetailScreen(country: country),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
