import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widgets/Inherited/Provider.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const mainScreenMovieDetails = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) {
    return isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.auth;
  }

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.auth: (context) =>
        NotifierProviderr(model: AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => const MainScreenWidget(),
    MainNavigationRouteNames.mainScreenMovieDetails: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is int) {
        return MovieDetailsWidget(Movieid: arguments);
      } else {
        return MovieDetailsWidget(Movieid: 0);
      }
    }
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.mainScreenMovieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => MovieDetailsWidget(Movieid: movieId),
        );
      default:
        const widget = Text('Navigation error !!!');
        return MaterialPageRoute(
          builder: (context) => widget,
        );
    }
  }
}
