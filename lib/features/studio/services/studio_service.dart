import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/shared_prefs_helper.dart';

class StudioService {
  static Future<Map<String, String>> _getHeaders() async {
    final token = await SharedPrefsHelper.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> getStudioDetails(int id) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.studioDetails(id)),
        headers: await _getHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static void _handleException(dynamic e) {
    print('API Error (Studio): $e');
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
