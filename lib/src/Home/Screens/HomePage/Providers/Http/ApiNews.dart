import 'package:http/http.dart' show Client;
import 'package:inicio/src/Home/Screens/HomePage/Providers/News.dart';

class ApiNews {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/photos';

  final Client _client = Client();

  Future<List<News>> getNews() async {
    List<News> newsList;

    final response = await _client.get(baseUrl);
    newsList = newsFromJson(response.body);

    return newsList;
  }
}
