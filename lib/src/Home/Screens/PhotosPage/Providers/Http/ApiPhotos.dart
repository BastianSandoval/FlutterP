import 'package:http/http.dart' show Client;
import 'package:inicio/src/Home/Screens/PhotosPage/Providers/photos.dart';

class ApiPhotos {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/photos';

  final Client _client = Client();

  Future<List<Photos>> getPhotos() async {
    List<Photos> photosList;

    final response = await _client.get(baseUrl);
    photosList = photosFromJson(response.body);

    return photosList;
  }
  /* Future setPlan( { List<Plan> data}) async {
    List<Plan> planList;

    planList = planToJson(data);

    final Response =
  }*/
}
