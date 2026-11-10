import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/categories/categories_cubit.dart';
import '../cubits/categories/categories_state.dart';
import '../cubits/meals/meals_cubit.dart';
import '../cubits/meals/meals_state.dart';
import '../widgets/recipe_card.dart';
import '../widgets/featured_recipe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Beef';

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().fetchCategories();
    context.read<MealsCubit>().fetchMeals(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header UI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(height: 4),
                      Text('Alena Sabyan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Featured Section
              const Text('Featured', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              BlocBuilder<MealsCubit, MealsState>(
                builder: (context, state) {
                  if (state is MealsSuccess && state.meals.isNotEmpty) {
                    return FeaturedRecipeCard(meal: state.meals.first);
                  }
                  return const SizedBox(height: 150, child: Center(child: CircularProgressIndicator()));
                },
              ),

              const SizedBox(height: 24),

              // Category Horizontal List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: Color(0xFF65B8B1)))),
                ],
              ),
              SizedBox(
                height: 40,
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesSuccess) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final cat = state.categories[index];
                          final isSelected = cat.strCategory == selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = cat.strCategory;
                              });
                              context.read<MealsCubit>().fetchMeals(cat.strCategory);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF65B8B1) : Colors.grey[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cat.strCategory,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Popular Recipes Grid
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Popular Recipes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: Color(0xFF65B8B1)))),
                ],
              ),
              BlocBuilder<MealsCubit, MealsState>(
                builder: (context, state) {
                  if (state is MealsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MealsSuccess) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: state.meals.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(meal: state.meals[index]);
                      },
                    );
                  }
                  return const Center(child: Text('Failed to load recipes'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}