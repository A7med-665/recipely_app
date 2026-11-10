import '../../models/meal_model.dart';

abstract class FavoritesState {}
class FavoritesInitial extends FavoritesState {}
class FavoritesLoading extends FavoritesState {}
class FavoritesSuccess extends FavoritesState {
  final List<MealModel> favorites;
  FavoritesSuccess(this.favorites);
}
class FavoritesError extends FavoritesState {
  final String message;
  FavoritesError(this.message);
}