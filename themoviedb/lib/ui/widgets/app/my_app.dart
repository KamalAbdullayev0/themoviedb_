import 'package:themoviedb/ui/Theme/app_colors.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.mainDarkBlue),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
      ),
      routes: mainNavigation.routes,
      initialRoute: '/auth',
      //routingi tekrarlamaq ucun∏

      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute<void>(
      //     builder: (context) {
      //       return Scaffold(
      //         appBar: AppBar(
      //           title: const Text('Error'),
      //         ),
      //         body: Center(
      //           child: Text('No route defined for ${settings.name}'),
      //         ),
      //       );
      //     },
      //   );
      // },
    );
  }
}
