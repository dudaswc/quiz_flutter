/*
Nome: CreateMaterialApp()
Descrição: Cria o objeto MaterialApp com as rotas e suas respectivas classes
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'package:flutter/material.dart';

import '../Screens/login/login_page.dart';
import '../Screens/photo/photo_page.dart';
import '../Screens/profile/profile_page.dart';
import '../Screens/quiz/quiz_page.dart';
import '../Screens/registration/register_page.dart';
import '../Screens/result/result_page.dart';
import 'app_routes.dart';

Widget createMaterialApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Desperte Mulher',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFF7FB),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF7B2D8B),
        primary: const Color(0xFF7B2D8B),
        secondary: const Color(0xFFD81B60),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF7B2D8B),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7B2D8B),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    initialRoute: AppRoutes.quizPage,
    routes: {
      AppRoutes.loginPage: (_) => LoginPage(),
      AppRoutes.profilePage: (_) => ProfilePage(),
      AppRoutes.registerPage: (_) => RegisterPage(),
      AppRoutes.photoPage: (_) => SelectPhotoPage(),
      AppRoutes.quizPage: (_) => const QuizPage(),
      AppRoutes.resultPage: (_) => const ResultPage(),
    },
  );
}
