import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../screens/details_screen.dart';

class FeaturedRecipeCard extends StatelessWidget {
  final MealModel meal;

  const FeaturedRecipeCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heroTag = 'featured_${meal.idMeal}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              mealId: meal.idMeal,
              heroTag: heroTag,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          color: const Color(0xFF89CFF0).withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: 10,
              bottom: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Hero(
                  tag: heroTag,
                  child: Image.network(
                    meal.strMealThumb,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      meal.strMeal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E272E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFF65B8B1),
                        child: Icon(Icons.person, size: 14, color: Colors.white),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'James Spader',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.access_time, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('20 Min', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}