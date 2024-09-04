import 'package:flutter/material.dart';
import 'package:gipy/Apis/gypyService.dart';
import 'package:provider/provider.dart';


class GifSearchScreen extends StatefulWidget {
  @override
  _GifSearchScreenState createState() => _GifSearchScreenState();
}

class _GifSearchScreenState extends State<GifSearchScreen> {
  final _searchController = TextEditingController();
  final _giphyService = GiphyService();
  List<String> _gifs = [];
  bool _isLoading = false;
  int _offset = 0;
  String _searchQuery = '';

  void _searchGIFs() async {
    setState(() {
      _isLoading = true;
    });
    _gifs = await _giphyService.searchGIFs(_searchQuery, _offset);
    setState(() {
      _isLoading = false;
    });
  }

  void _loadTrendingGIFs() async {
    setState(() {
      _isLoading = true;
    });
    _gifs = await _giphyService.getTrendingGIFs(_offset);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTrendingGIFs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giphy Search')),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(labelText: 'Search GIFs'),
            onChanged: (value) {
              _searchQuery = value;
              if (_searchQuery.isEmpty) {
                _loadTrendingGIFs();
              } else {
                _searchGIFs();
              }
            },
          ),
          _isLoading ? CircularProgressIndicator() : Expanded(
            child: GridView.builder(
              itemCount: _gifs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (ctx, i) => Image.network(_gifs[i]),
            ),
          ),
        ],
      ),
    );
  }
}
