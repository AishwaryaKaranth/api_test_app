import 'dart:convert';
import 'package:http/http.dart';
import 'package:api_test_app/model.dart';

class ApiService {
  final String api = "";

  Future<List<Album>> getAlbums() async {
    Response response = await get(api as Uri);
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      List<Album> albums =
          result.map((dynamic item) => Album.fromJson(item)).toList();
      return albums;
    } else {
      throw 'Failed fetching albums';
    }
  }

  Future<Album> getAlbumById(int id) async {
    Response response = await get('$api/${id}' as Uri);
    if (response.statusCode == 200) {
      dynamic result = jsonDecode(response.body);
      Album album = result.map((dynamic item) => Album.fromJson(item)).toList();
      return album;
    } else {
      throw 'Failed in fetching Album';
    }
  }

  Future<void> deleteAlbum(int id) async {
    Response response = await delete('$api/${id}' as Uri);
    if (response.statusCode == 200) {
      print('Album deleted');
    } else {
      throw 'Could not delete album';
    }
  }

  Future<Album> createAlbum(Album album) async {
    Map data = {'userId': album.userId, 'id': album.id, 'title': album.title};

    Response response = await post('$api' as Uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      //List<dynamic> result = Album.fromJson(json.decode(response.body));
      //List<Album> albums = result.map((dynamic item)=>Album.fromJson(result));
      return Album.fromJson(json.decode(response.body));
    } else {
      throw 'Error creating an album';
    }
  }

  Future<Album> updateAlbum(Album album, int id) async {
    Map data = {'userId': album.userId, 'id': album.id, 'title': album.title};

    Response response = await put('$api/${id}' as Uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      dynamic result = Album.fromJson(json.decode(response.body));
      Album album = result.map((dynamic item) => Album.fromJson(result));
      return album;
    } else {
      throw 'Could not update Album';
    }
  }
}
