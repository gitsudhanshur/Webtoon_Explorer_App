import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'webtoon.dart';
import 'favorite_manager.dart';

class DetailScreen extends StatefulWidget {
  final Webtoon webtoon;

  DetailScreen({required this.webtoon});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double _currentRating = 0.0;
  double _averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    _loadRating();
  }

  Future<void> _loadRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? savedRating = prefs.getDouble('rating_${widget.webtoon.title}');
    setState(() {
      _currentRating = savedRating ?? 0.0;
      _averageRating = savedRating ?? 0.0;
    });
  }

  Future<void> _saveRating(double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('rating_${widget.webtoon.title}', rating);
    setState(() {
      _currentRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.webtoon.title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.webtoon.thumbnailUrl),
            SizedBox(height: 10),
            Text(
              widget.webtoon.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Your Rating:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              initialRating: _currentRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _saveRating(rating);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Average Rating: $_averageRating',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                List<Webtoon> favorites = await FavoriteManager.loadFavorites();
                if (!favorites.contains(widget.webtoon)) {
                  favorites.add(widget.webtoon);
                  await FavoriteManager.saveFavorites(favorites);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added to Favorites!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Already in Favorites!')),
                  );
                }
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
