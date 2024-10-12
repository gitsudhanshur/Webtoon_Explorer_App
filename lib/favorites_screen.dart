import 'package:flutter/material.dart';
import 'webtoon.dart';
import 'favorite_manager.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Webtoon> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Webtoon> loadedFavorites = await FavoriteManager.loadFavorites();
    setState(() {
      favorites = loadedFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favorites.isNotEmpty
          ? ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favorites[index].title),
                  leading: Image.asset(favorites[index].thumbnailUrl),
                );
              },
            )
          : Center(
              child: Text('No favorites added yet.'),
            ),
    );
  }
}
