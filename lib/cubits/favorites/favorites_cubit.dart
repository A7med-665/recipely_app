import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/meal_model.dart';
import '../../services/favorites_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesService favoritesService;
  FavoritesCubit(this.favoritesService) : super(FavoritesInitial());

  void loadFavorites() async {
    emit(FavoritesLoading());
    try {
      final favorites = await favoritesService.getFavorites();
      emit(FavoritesSuccess(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites'));
    }
  }

  void toggleFavorite(MealModel meal) async {
    await favoritesService.toggleFavorite(meal);
    loadFavorites();
  }
}