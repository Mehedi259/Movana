import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/shared_prefs_helper.dart';

class SearchService {
  static Future<List<dynamic>> searchClasses(String query) async {
    final token = await SharedPrefsHelper.getAccessToken();
    if (token == null) throw Exception('No authentication token found');

    final response = await http.get(
      Uri.parse(ApiConstants.classesSearch(query)),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedData = utf8.decode(response.bodyBytes);
      final jsonResponse = jsonDecode(decodedData);
      if (jsonResponse is List) return jsonResponse;
      if (jsonResponse is Map && jsonResponse.containsKey('results')) return jsonResponse['results'] as List;
      return [jsonResponse];
    } else {
      throw Exception('Failed to load search results: ${response.statusCode}');
    }
  }
}
