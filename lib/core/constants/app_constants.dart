
import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  static const String appName = 'Recipely';

  static const String baseUrl =
      'https://www.themealdb.com/api/json/v1/1/';

  static const String categoriesEndpoint = 'categories.php';

  static const String filterEndpoint = 'filter.php';

  static const String searchEndpoint = 'search.php';

  static const String detailsEndpoint = 'lookup.php';

  static const String favoritesKey = 'recipely_favorites';

  static const Color primary = Color(0xFF75B9BD);

  static const Color primaryDark = Color(0xFF062F32);

  static const Color background = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFFF4F6F6);

  static const Color textPrimary = Color(0xFF172F38);

  static const Color textSecondary = Color(0xFF9CA9AC);

  static const Color border = Color(0xFFE9EEEE);

  static const Color error = Color(0xFFD9534F);

  static const double horizontalPadding = 24.0;

  static const double cardRadius = 20.0;
}
