import 'package:flutter/material.dart';
import 'package:themoviedb/resources/app_images.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _TopPosterWidget(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: _SummeryWidget(),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: _RomeWidget(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _OvervieewWidget(),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        SizedBox(height: 15),
        _PeopleWidgets(),
        SizedBox(height: 15),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "JJ, a veteran CIA agent, reunites with his protégé Sophie, in order to prevent a catastrophic nuclear plot targeting the Vatican.",
      style: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _OvervieewWidget extends StatelessWidget {
  const _OvervieewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Owerview",
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _RomeWidget extends StatelessWidget {
  const _RomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Rome isn't ready.",
      style: TextStyle(
        color: const Color.fromARGB(255, 93, 82, 82),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Image(
          image: AssetImage(AppImages.arxa1),
        ),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(
            image: AssetImage(AppImages.images1),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'My Spy The Eternal City',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ' (2024)',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: RadialPercentWidget(),
              ),
              SizedBox(width: 10),
              Text('User score'),
            ],
          ),
        ),
        Container(width: 1, height: 20, color: Colors.black),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.play_arrow, color: Colors.black),
              SizedBox(width: 5),
              Text('Play Trailer'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'PG-1318/07/2024 (US) Action, Comedy 1h 52m',
      maxLines: 3,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final jobStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    final nameStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Erich Hoeber', style: nameStyle),
                Text('Characters, Screenplay, Story', style: jobStyle),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jon Hoeber', style: nameStyle),
                Text('Characters, Screenplay, Story', style: jobStyle),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(right: 220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Peter Segal', style: nameStyle),
              Text('Director, Screenplay, Story', style: jobStyle),
            ],
          ),
        ),
      ],
    );
  }
}
