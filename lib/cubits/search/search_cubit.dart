import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/meal_service.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MealService mealService;
  SearchCubit(this.mealService) : super(SearchInitial());

  void searchMeals(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final meals = await mealService.searchMeals(query);
      emit(SearchSuccess(meals));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}