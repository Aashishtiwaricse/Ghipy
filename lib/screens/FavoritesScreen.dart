import 'package:flutter/material.dart';
import 'package:gipy/screens/FavoritesService.dart';


class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> _favorites = [];
  final _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    _favorites = await _favoritesService.getFavorites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: GridView.builder(
        itemCount: _favorites.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (ctx, i) => Image.network(_favorites[i]),
      ),
    );
  }
}
