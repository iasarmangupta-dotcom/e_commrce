import 'package:flutter/material.dart';
import '../Ui/Dashboard/Dashboard.dart';
import '../Ui/Nav_pages/cart_page.dart';
import '../Ui/Splsh/Splash_page.dart';
import '../Ui/pages/address/address_page.dart';
import '../Ui/pages/login/login_page.dart';
import '../Ui/pages/product_detail/product_detail_page.dart';
import '../Ui/pages/singup/singup_page.dart';

class AppRoutes {
  static const String PAGE_SPLASH = "/";
  static const String PAGE_LOGIN = "/login";
  static const String PAGE_SIGN_UP = "/signup";
  static const String PAGE_DASHBOARD = "/dashboard";
  static const String PAGE_PRODUCT_DETAIL = "/product_detail";
  static const String PAGE_CART = "/cart";
  static const String PAGE_ADDRESS = "/address";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      PAGE_SPLASH: (context) => const SplashPage(),
      PAGE_LOGIN: (context) => const LoginPage(),
      PAGE_SIGN_UP: (context) => const SignUpPage(),
      PAGE_DASHBOARD: (context) => const DashboardPage(),
      PAGE_PRODUCT_DETAIL: (context) => const ProductDetailPage(),
      PAGE_CART: (context) => const CartPage(),
      PAGE_ADDRESS: (context) => const AddressPage(),
    };
  }
}
