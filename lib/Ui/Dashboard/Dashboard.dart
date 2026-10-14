import 'package:flutter/material.dart';
import '../Nav_pages/cart_page.dart';
import '../Nav_pages/nav_home_page.dart';
import '../Nav_pages/profile_page.dart';
import '../Nav_pages/wishlist_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedNavIndex = 0; // Default to Home (center button)

  final List<Widget> pages = [
    const NavHomePage(),
    const WishlistPage(),
    const CartPage(showBackButton: false),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedNavIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          elevation: 4,
          onPressed: () {
            setState(() {
              selectedNavIndex = 0; // Go to Home
            });
          },
          backgroundColor: const Color(0xFFFF5722),
          shape: const CircleBorder(),
          child: const Icon(Icons.home_rounded, color: Colors.white, size: 28),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Grid / Categories Icon
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: selectedNavIndex == 0 ? const Color(0xFFFF5722) : Colors.grey,
                  size: 22,
                ),
              ),

              // Favorites Icon
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 1;
                  });
                },
                icon: Icon(
                  selectedNavIndex == 1 ? Icons.favorite : Icons.favorite_border_rounded,
                  color: selectedNavIndex == 1 ? const Color(0xFFFF5722) : Colors.grey,
                  size: 22,
                ),
              ),

              const SizedBox(width: 40), // Gap for FAB

              // Cart Icon
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 2;
                  });
                },
                icon: Icon(
                  selectedNavIndex == 2 ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                  color: selectedNavIndex == 2 ? const Color(0xFFFF5722) : Colors.grey,
                  size: 22,
                ),
              ),

              // Profile Icon
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedNavIndex = 3;
                  });
                },
                icon: Icon(
                  selectedNavIndex == 3 ? Icons.person : Icons.person_outline_rounded,
                  color: selectedNavIndex == 3 ? const Color(0xFFFF5722) : Colors.grey,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
