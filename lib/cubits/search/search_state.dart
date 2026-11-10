import '../../models/meal_model.dart';

abstract class SearchState {}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState {
  final List<MealModel> meals;
  SearchSuccess(this.meals);
}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}