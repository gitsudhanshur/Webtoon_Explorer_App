import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'webtoon.dart';

class FavoriteManager {
  static const String favoriteKey = 'favoriteWebtoons';

  static Future<void> saveFavorites(List<Webtoon> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteJsonList = favorites.map((webtoon) => jsonEncode(webtoon.toJson())).toList();
    await prefs.setStringList(favoriteKey, favoriteJsonList);
  }

  Future<void> clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  }

  static Future<List<Webtoon>> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteJsonList = prefs.getStringList(favoriteKey);
    if (favoriteJsonList != null) {
      return favoriteJsonList.map((jsonString) => Webtoon.fromJson(jsonDecode(jsonString))).toList();
    }
    return [];
  }
}
