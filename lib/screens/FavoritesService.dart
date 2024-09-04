import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  Future<void> addToFavorites(String gifUrl) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(gifUrl);
    await prefs.setStringList('favorites', favorites);
  }

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }
}
