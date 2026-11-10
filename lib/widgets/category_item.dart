import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF008080) : Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                category.strCategoryThumb,
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.fastfood, size: 20),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              category.strCategory,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}