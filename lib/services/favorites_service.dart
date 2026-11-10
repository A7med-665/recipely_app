import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';

class FavoritesService {
  static const String _key = 'favorite_meals';

  Future<List<MealModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList(_key) ?? [];
    return items.map((e) => MealModel.fromJson(jsonDecode(e))).toList();
  }

  Future<bool> isFavorite(String mealId) async {
    final favorites = await getFavorites();
    return favorites.any((element) => element.idMeal == mealId);
  }

  Future<void> toggleFavorite(MealModel meal) async {
    final prefs = await SharedPreferences.getInstance();
    List<MealModel> favorites = await getFavorites();

    bool exists = favorites.any((e) => e.idMeal == meal.idMeal);
    if (exists) {
      favorites.removeWhere((e) => e.idMeal == meal.idMeal);
    } else {
      favorites.add(meal);
    }

    List<String> encodedList = favorites.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, encodedList);
  }
}