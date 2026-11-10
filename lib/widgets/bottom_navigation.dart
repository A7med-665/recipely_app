import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/favorites_screen.dart';

class MainBottomNavigation extends StatefulWidget {
  const MainBottomNavigation({Key? key}) : super(key: key);

  @override
  State<MainBottomNavigation> createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined, size: 28, color: _currentIndex == 0 ? const Color(0xFF65B8B1) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: Icon(Icons.search, size: 28, color: _currentIndex == 1 ? const Color(0xFF65B8B1) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            // Floating Chef Hat Icon matching Doc1 PDF
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color(0xFF0F3A34),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.restaurant_menu, color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite_border, size: 28, color: _currentIndex == 2 ? const Color(0xFF65B8B1) : Colors.grey),
              onPressed: () => setState(() => _currentIndex = 2),
            ),
            IconButton(
              icon: const Icon(Icons.person_outline, size: 28, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}