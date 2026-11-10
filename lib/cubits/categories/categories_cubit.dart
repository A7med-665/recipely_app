import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/meal_service.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final MealService mealService;
  CategoriesCubit(this.mealService) : super(CategoriesInitial());

  void fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await mealService.getCategories();
      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}