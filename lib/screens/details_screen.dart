import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal_model.dart';
import '../services/meal_service.dart';
import '../cubits/favorites/favorites_cubit.dart';
import '../cubits/favorites/favorites_state.dart';

class DetailsScreen extends StatefulWidget {
  final String mealId;
  final String? heroTag;

  const DetailsScreen({
    Key? key,
    required this.mealId,
    this.heroTag,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  MealModel? meal;
  bool isLoading = true;
  bool isIngredientsTab = true;

  @override
  void initState() {
    super.initState();
    _loadMealDetails();
  }

  void _loadMealDetails() async {
    final result = await MealService().getMealDetails(widget.mealId);
    if (mounted) {
      setState(() {
        meal = result;
        isLoading = false;
      });
    }
  }

  void _openYoutube(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tag = widget.heroTag ?? widget.mealId;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF65B8B1)))
          : meal == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No details found'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      )
          : Stack(
        children: [
          // Content Scroll
          SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: tag,
                  child: Image.network(
                    meal!.strMealThumb,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  transform: Matrix4.translationValues(0, -30, 0),
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              meal!.strMeal,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text('15 Min', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tabs
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isIngredientsTab = true),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isIngredientsTab ? const Color(0xFF0F3A34) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Ingredients',
                                      style: TextStyle(
                                        color: isIngredientsTab ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => isIngredientsTab = false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: !isIngredientsTab ? const Color(0xFF0F3A34) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Instructions',
                                      style: TextStyle(
                                        color: !isIngredientsTab ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      if (isIngredientsTab) ...[
                        Text(
                          '${meal!.ingredients.length} Items',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: meal!.ingredients.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FBFC),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    meal!.ingredients[index],
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    meal!.measures.length > index ? meal!.measures[index] : '',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ] else ...[
                        Text(
                          meal!.strInstructions ?? '',
                          style: const TextStyle(fontSize: 14, height: 1.6),
                        ),
                      ],
                      const SizedBox(height: 24),
                      if (meal!.strYoutube != null && meal!.strYoutube!.isNotEmpty)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF65B8B1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () => _openYoutube(meal!.strYoutube!),
                            icon: const Icon(Icons.play_arrow, color: Colors.white),
                            label: const Text(
                              'Watch Video',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Top Action Bar (Back & Favorite) - مثبت في أعلى الشاشة فوق كل العناصر
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر الرجوع المباشر
                    Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      elevation: 4,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ),
                    // زر المفضلة العلوي
                    if (meal != null)
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = (state is FavoritesSuccess) &&
                              state.favorites.any((e) => e.idMeal == meal!.idMeal);
                          return Material(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            elevation: 4,
                            child: IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                context.read<FavoritesCubit>().toggleFavorite(meal!);
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}