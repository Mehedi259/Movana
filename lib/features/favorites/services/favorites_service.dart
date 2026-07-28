import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/shared_prefs_helper.dart';

class FavoritesService {
  static Future<List<dynamic>> getFavoriteStudios() async {
    final token = await SharedPrefsHelper.getAccessToken();
    if (token == null) throw Exception('No authentication token found');

    final response = await http.get(
      Uri.parse(ApiConstants.favoriteStudios),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedData = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedData) as List<dynamic>;
    } else {
      throw Exception('Failed to load favorite studios: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getFavoriteClasses() async {
    final token = await SharedPrefsHelper.getAccessToken();
    if (token == null) throw Exception('No authentication token found');

    final response = await http.get(
      Uri.parse(ApiConstants.favoriteClasses),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedData = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedData) as List<dynamic>;
    } else {
      throw Exception('Failed to load favorite classes: ${response.statusCode}');
    }
  }

  static Future<bool> toggleFavoriteStudio(int id) async {
    final token = await SharedPrefsHelper.getAccessToken();
    if (token == null) throw Exception('No authentication token found');

    final response = await http.post(
      Uri.parse(ApiConstants.toggleFavoriteStudio(id)),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedData);
      return jsonResponse['is_favorite'] == true;
    } else {
      throw Exception('Failed to toggle favorite studio: ${response.statusCode}');
    }
  }

  static Future<bool> toggleFavoriteClass(int id) async {
    final token = await SharedPrefsHelper.getAccessToken();
    if (token == null) throw Exception('No authentication token found');

    final response = await http.post(
      Uri.parse(ApiConstants.toggleFavoriteClass(id)),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedData = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedData);
      return jsonResponse['is_favorite'] == true;
    } else {
      throw Exception('Failed to toggle favorite class: ${response.statusCode}');
    }
  }
}
