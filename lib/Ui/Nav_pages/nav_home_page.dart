import 'package:flutter/material.dart';
import '../../Data/dummy_data.dart';
import '../../Data/helper/api_helper.dart';
import '../../Data/models/product_model.dart';
import '../../Data/repositories/product_repository.dart';
import '../../Domin/app_routes.dart';

class NavHomePage extends StatefulWidget {
  const NavHomePage({super.key});

  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  final ProductRepository _productRepo = ProductRepository(apiHelper: ApiHelper());

  List<ProductModel> productsList = DummyData.products;
  List<Map<String, dynamic>> categoriesList = DummyData.categories;

  bool isLoading = true;
  int activeCategoryIndex = 0;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadApiData();
  }

  Future<void> _loadApiData() async {
    try {
      final fetchedProducts = await _productRepo.getProducts();
      final fetchedCategories = await _productRepo.getCategories();

      if (mounted) {
        setState(() {
          productsList = fetchedProducts;
          categoriesList = fetchedCategories;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> filteredProducts = productsList.where((prod) {
      bool matchesSearch = searchQuery.isEmpty ||
          prod.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          prod.category.toLowerCase().contains(searchQuery.toLowerCase());

      if (activeCategoryIndex == 0) return matchesSearch;

      String selectedCatName = categoriesList[activeCategoryIndex]["name"]
          .toString()
          .replaceAll("\n", " ");

      bool matchesCategory = prod.category.toLowerCase().contains(selectedCatName.toLowerCase());

      return matchesSearch && matchesCategory;
    }).toList();

    if (filteredProducts.isEmpty && searchQuery.isEmpty) {
      filteredProducts = productsList;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadApiData,
          color: Colors.deepOrange,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.grid_view_rounded, size: 20, color: Colors.black87),
                        onPressed: () {},
                      ),
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.notifications_none_rounded, size: 22, color: Colors.black87),
                            onPressed: () {},
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.deepOrange,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Search Bar with Filter Icon
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              searchQuery = val;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      IconButton(
                        icon: const Icon(Icons.tune_rounded, color: Colors.black87, size: 20),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Super Sale Banner
                Container(
                  width: double.infinity,
                  height: 155,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E3DF),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Super Sale\nDiscount\nUp to 50%",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 32,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF5722),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Shop Now",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=600",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image, size: 60),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Banner Indicator Dots
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      4,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: index == 1 ? 16 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: index == 1 ? Colors.black : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // Categories List (Horizontal)
                SizedBox(
                  height: 85,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder: (context, index) {
                      final cat = categoriesList[index];
                      bool isSelected = activeCategoryIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            activeCategoryIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundColor:
                                    isSelected ? Colors.deepOrange : Colors.white,
                                child: Icon(
                                  cat["icon"] is IconData
                                      ? cat["icon"] as IconData
                                      : Icons.category,
                                  color: isSelected ? Colors.white : Colors.black87,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cat["name"].toString().split("\n").first,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 15),

                // Special For You Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Loading Indicator / Product Grid
                isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(color: Colors.deepOrange),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                        itemBuilder: (context, index) {
                          final prod = filteredProducts[index];
                          return _buildProductCard(context, prod);
                        },
                      ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel prod) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.PAGE_PRODUCT_DETAIL,
          arguments: prod,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Right Favorite Button & Image Container with Rounded Clip
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Hero(
                        tag: 'product_img_${prod.id}',
                        child: Image.network(
                          prod.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.image, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          prod.isFavorite = !prod.isFavorite;
                        });
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color(0xFFFF5722),
                        child: Icon(
                          prod.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Product Title
            Text(
              prod.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Price & Color Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${prod.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: List.generate(
                    prod.colors.length > 3 ? 3 : prod.colors.length,
                    (cIndex) => Container(
                      margin: const EdgeInsets.only(left: 2),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: prod.colors[cIndex],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
