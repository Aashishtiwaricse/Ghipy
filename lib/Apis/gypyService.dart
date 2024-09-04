import 'dart:convert';
import 'package:http/http.dart' as http;

class GiphyService {
  final String baseUrl = 'https://developers.giphy.com/docs/api/';

  Future<List<String>> searchGIFs(String query, int offset) async {
    final url = '$baseUrl/search?q=$query&offset=$offset&limit=20';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> gifs = [];
      for (var gif in data['data']) {
        gifs.add(gif['images']['fixed_height']['url']);
      }
      return gifs;
    } else {
      throw Exception('Failed to load GIFs');
    }
  }

  

  Future<List<String>> getTrendingGIFs(int offset) async {
    final url = '$baseUrl/trending?offset=$offset&limit=20';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> gifs = [];
      for (var gif in data['data']) {
        gifs.add(gif['images']['fixed_height']['url']);
      }
      return gifs;
    } else {
      throw Exception('Failed to load GIFs');
    }
  }
}
