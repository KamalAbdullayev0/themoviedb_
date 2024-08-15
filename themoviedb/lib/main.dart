import 'package:flutter/material.dart';
import 'package:themoviedb/ui/Theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
      routes: {
        '/auth': (context) => const AuthWidget(),
        '/main_screen': (context) => const MainScreenWidget(),
        '/main_screen/movie_details': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MovieDetailsWidget(Movieid: arguments);
          } else {
            return MovieDetailsWidget(Movieid: 0);
          }

          // final id = ModalRoute.of(context)?.settings.arguments as int;
          // return MovieDetailsWidget(Movieid: id);
        }

      },
      initialRoute: '/auth',
      //routingi tekrarlamaq ucun

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
