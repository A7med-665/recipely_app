import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/meal_model.dart';
import '../../services/meal_service.dart';
import 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final MealService mealService;
  MealsCubit(this.mealService) : super(MealsInitial());

  void fetchMeals(String category) async {
    emit(MealsLoading());
    try {
      final meals = await mealService.getMealsByCategory(category);
      emit(MealsSuccess(meals));
    } catch (e) {
      emit(MealsError(e.toString()));
    }
  }
}