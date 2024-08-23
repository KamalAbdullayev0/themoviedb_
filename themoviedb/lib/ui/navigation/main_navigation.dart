import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const mainScreenMovieDetails = '/main_screen/movie_details';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    '/auth': (context) =>
        AuthProvider(model: AuthModel(), child: const AuthWidget()),
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
  };
}
