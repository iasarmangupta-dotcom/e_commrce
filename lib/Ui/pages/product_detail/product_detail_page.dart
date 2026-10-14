import 'package:flutter/material.dart';
import '../../../Data/dummy_data.dart';
import '../../../Data/models/cart_item_model.dart';
import '../../../Data/models/product_model.dart';
import '../../../Domin/app_routes.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel? product;

  const ProductDetailPage({super.key, this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductModel currentProduct;
  int selectedColorIndex = 0;
  int activeTab = 0; // 0: Description, 1: Specifications, 2: Reviews
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    currentProduct = widget.product ?? DummyData.products[0];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ProductModel) {
      currentProduct = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.share_outlined, size: 20, color: Colors.black87),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Sharing product link...")),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: IconButton(
                          icon: Icon(
                            currentProduct.isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: currentProduct.isFavorite ? Colors.red : Colors.black87,
                          ),
                          onPressed: () {
                            setState(() {
                              currentProduct.isFavorite = !currentProduct.isFavorite;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Product Image Section with Dots
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: Hero(
                      tag: 'product_img_${currentProduct.id}',
                      child: Image.network(
                        currentProduct.imageUrl,
                        fit: BoxFit.contain,
                        height: 220,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          width: 200,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, size: 60, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    child: Row(
                      children: List.generate(
                        4,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: index == 1 ? 16 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: index == 1 ? Colors.black87 : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Container Sheet
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Seller
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentProduct.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${currentProduct.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Seller: ${currentProduct.seller}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Rating Badge
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 14, color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                "${currentProduct.rating}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "(${currentProduct.reviewCount} Review)",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Color Selection
                    const Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(
                        currentProduct.colors.length,
                        (index) {
                          bool isSelected = selectedColorIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColorIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.deepOrange : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: currentProduct.colors[index],
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        size: 14,
                                        color: currentProduct.colors[index].computeLuminance() > 0.5
                                            ? Colors.black
                                            : Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tabs [Description, Specifications, Reviews]
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTabButton("Description", 0),
                        _buildTabButton("Specifications", 1),
                        _buildTabButton("Reviews", 2),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Tab Content Text
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          activeTab == 0
                              ? currentProduct.description
                              : activeTab == 1
                                  ? "Material: Premium Blend\nConnectivity: Bluetooth 5.2\nBattery Life: Up to 30 hours\nWarranty: 1 Year Manufacturer Warranty"
                                  : "Reviews (320):\n★ ★ ★ ★ ★ - John D.: Amazing sound quality!\n★ ★ ★ ★ ☆ - Sarah M.: Very comfortable for long use.",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Bottom Row: Quantity + Add to Cart Button
                    Row(
                      children: [
                        // Quantity pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove, color: Colors.white, size: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  "$quantity",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: const Icon(Icons.add, color: Colors.white, size: 18),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 15),

                        // Add to Cart Button
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF5722),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                DummyData.cartItems.add(
                                  CartItemModel(
                                    product: currentProduct,
                                    quantity: quantity,
                                    selectedColor: currentProduct.colors.isNotEmpty
                                        ? currentProduct.colors[selectedColorIndex]
                                        : Colors.black,
                                  ),
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${currentProduct.title} added to Cart!"),
                                    action: SnackBarAction(
                                      label: "VIEW CART",
                                      textColor: Colors.amber,
                                      onPressed: () {
                                        Navigator.pushNamed(context, AppRoutes.PAGE_CART);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = activeTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
