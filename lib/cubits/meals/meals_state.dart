import '../../models/meal_model.dart';

abstract class MealsState {}
class MealsInitial extends MealsState {}
class MealsLoading extends MealsState {}
class MealsSuccess extends MealsState {
  final List<MealModel> meals;
  MealsSuccess(this.meals);
}
class MealsError extends MealsState {
  final String message;
  MealsError(this.message);
}