import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services/meal_service.dart';
import 'services/favorites_service.dart';
import 'cubits/categories/categories_cubit.dart';
import 'cubits/meals/meals_cubit.dart';
import 'cubits/search/search_cubit.dart';
import 'cubits/favorites/favorites_cubit.dart';
import 'widgets/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealService = MealService();
    final favoritesService = FavoritesService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesCubit(mealService),
        ),
        BlocProvider(
          create: (context) => MealsCubit(mealService),
        ),
        BlocProvider(
          create: (context) => SearchCubit(mealService),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(favoritesService)..loadFavorites(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food Recipe App',
        theme: ThemeData(
          primaryColor: const Color(0xFF008080),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        home: const MainBottomNavigation(),
      ),
    );
  }
}