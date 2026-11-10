import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/favorites/favorites_cubit.dart';
import '../cubits/favorites/favorites_state.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesCubit>().loadFavorites();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesSuccess) {
            if (state.favorites.isEmpty) {
              return const Center(child: Text('No favorite recipes added yet'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                return RecipeCard(meal: state.favorites[index]);
              },
            );
          }
          return const Center(child: Text('Failed to load favorites'));
        },
      ),
    );
  }
}