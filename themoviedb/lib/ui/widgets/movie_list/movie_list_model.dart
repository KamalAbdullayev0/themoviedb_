import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];
  late int _currentPage;
  var _isLoadingInProgress = false;
  late int _totalPages;
  List<Movie> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;
  String _locale = '';

  String stringFromDate(DateTime? date) =>
      date == null ? '' : _dateFormat.format(date);

  void setupLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (locale == _locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(locale);
    _totalPages = 1;
    _currentPage = 0;
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    if (_isLoadingInProgress || _currentPage >= _totalPages) return;
    _isLoadingInProgress = true;
    final nextPage = _currentPage + 1;
    try {
      final moviesResponse = await _apiClient.popularMovie(nextPage, _locale);
      _movies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPages = moviesResponse.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
        MainNavigationRouteNames.mainScreenMovieDetails,
        arguments: id);
  }

  void showedMovieAtIndex(int index) {
    if (index == _movies.length - 1) return;
    _loadMovies();
  }
}
