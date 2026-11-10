import 'package:dio/dio.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

class MealService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://www.themealdb.com/api/json/v1/1/'));

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('categories.php');
      final List data = response.data['categories'] ?? [];
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<MealModel>> getMealsByCategory(String category) async {
    try {
      final response = await _dio.get('filter.php?c=$category');
      final List? data = response.data['meals'];
      if (data == null) return [];
      return data.map((json) => MealModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load meals');
    }
  }

  Future<MealModel?> getMealDetails(String id) async {
    try {
      final response = await _dio.get('lookup.php?i=$id');
      final List? data = response.data['meals'];
      if (data == null || data.isEmpty) return null;
      return MealModel.fromJson(data[0]);
    } catch (e) {
      throw Exception('Failed to load meal details');
    }
  }

  Future<List<MealModel>> searchMeals(String query) async {
    try {
      final response = await _dio.get('search.php?s=$query');
      final List? data = response.data['meals'];
      if (data == null) return [];
      return data.map((json) => MealModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to search meals');
    }
  }
}