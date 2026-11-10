import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/meal_model.dart';
import '../screens/details_screen.dart';
import '../cubits/favorites/favorites_cubit.dart';
import '../cubits/favorites/favorites_state.dart';

class RecipeCard extends StatelessWidget {
  final MealModel meal;
  final String? heroTag;

  const RecipeCard({
    Key? key,
    required this.meal,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String uniqueHeroTag = heroTag ?? 'meal_${meal.idMeal}_${identityHashCode(this)}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // الضغط على الكارت للذهاب للتفاصيل
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    mealId: meal.idMeal,
                    heroTag: uniqueHeroTag,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Hero(
                      tag: uniqueHeroTag,
                      child: Image.network(
                        meal.strMealThumb,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.fastfood, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.strMeal,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1E272E),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Row(
                        children: [
                          Icon(Icons.local_fire_department, size: 14, color: Color(0xFF65B8B1)),
                          SizedBox(width: 4),
                          Text('120 Kcal', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          SizedBox(width: 8),
                          Icon(Icons.access_time, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('20 Min', style: TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // زرار المفضلة فوق الكارت بشرط استجابة حصرية (HitTestBehavior.opaque)
          Positioned(
            top: 8,
            right: 8,
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFav = (state is FavoritesSuccess) &&
                    state.favorites.any((e) => e.idMeal == meal.idMeal);
                return InkWell(
                  onTap: () {
                    context.read<FavoritesCubit>().toggleFavorite(meal);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey[400],
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}