import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/shared_prefs_helper.dart';

class HomeService {
  static Future<Map<String, String>> _getHeaders() async {
    final token = await SharedPrefsHelper.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> getCreditStatus() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.creditStatus),
        headers: await _getHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static Future<List<dynamic>> getClasses() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.classes),
        headers: await _getHeaders(),
      );
      return _processListResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static Future<List<dynamic>> getStudios() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.studios),
        headers: await _getHeaders(),
      );
      if (response.statusCode == 404) {
         // Fallback to explore/nearby if /studios/ is 404
         final fallbackResponse = await http.get(
           Uri.parse('${ApiConstants.baseUrl}/studios/nearby/?latitude=0&longitude=0&radius=1000'),
           headers: await _getHeaders(),
         );
         return _processListResponse(fallbackResponse);
      }
      return _processListResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static void _handleException(dynamic e) {
    print('API Error (Home): $e');
    if (!e.toString().startsWith('Exception: ')) {
      throw Exception('Failed to connect to server.');
    }
  }

  static Map<String, dynamic> _processResponse(http.Response response) {
    if (response.body.isEmpty) return {};
    final decoded = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded is Map ? decoded as Map<String, dynamic> : {'data': decoded};
    } else {
      throw Exception(_extractErrorMessage(decoded));
    }
  }

  static List<dynamic> _processListResponse(http.Response response) {
    if (response.body.isEmpty) return [];
    final decoded = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (decoded is List) return decoded;
      if (decoded is Map && decoded.containsKey('results')) return decoded['results'] as List;
      if (decoded is Map && decoded.containsKey('data')) return decoded['data'] as List;
      return [decoded];
    } else {
      throw Exception(_extractErrorMessage(decoded));
    }
  }

  static String _extractErrorMessage(dynamic decoded) {
    if (decoded is Map) {
      if (decoded.containsKey('errors') && decoded['errors'] is Map) {
        final errors = decoded['errors'] as Map;
        if (errors.containsKey('non_field_errors')) {
          return (errors['non_field_errors'] as List).join('\n');
        } else {
          return errors.values.first.toString();
        }
      } else if (decoded.containsKey('detail')) {
        return decoded['detail'];
      } else if (decoded.containsKey('message')) {
        return decoded['message'];
      }
    }
    return decoded.toString();
  }
}
