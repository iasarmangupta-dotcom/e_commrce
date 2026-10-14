import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Data/helper/api_helper.dart';
import 'app_routes.dart';
import '../Ui/bloc/user_block_dart/user_bloc.dart';
import '../Ui/widgets/responsive_web_frame.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserBloc(apiHelper: ApiHelper()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      ),
      builder: (context, child) {
        return ResponsiveWebFrame(child: child ?? const SizedBox());
      },
      initialRoute: AppRoutes.PAGE_SPLASH,
      routes: AppRoutes.getRoutes(),
    );
  }
}
