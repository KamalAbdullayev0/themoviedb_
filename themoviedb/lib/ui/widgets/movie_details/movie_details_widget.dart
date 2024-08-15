import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_main_screen_cast_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int Movieid;
  const MovieDetailsWidget({required this.Movieid, super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Movie Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ColoredBox(
          color: Color.fromRGBO(246, 221, 200, 1),
          child: ListView(
            children: [
              MovieDetailsMainInfoWidget(),
              MovieDetailsMainScreenCastWidget()
            ],
          ),
        ));
  }
}
