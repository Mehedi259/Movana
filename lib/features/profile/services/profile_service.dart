import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/shared_prefs_helper.dart';

class ProfileService {
  static Future<Map<String, String>> _getHeaders() async {
    final token = await SharedPrefsHelper.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.profile),
        headers: await _getHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
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

  static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data, {File? imageFile}) async {
    try {
      if (imageFile != null) {
        final token = await SharedPrefsHelper.getAccessToken();
        var request = http.MultipartRequest('PATCH', Uri.parse(ApiConstants.profile));
        
        request.headers.addAll({
          if (token != null) 'Authorization': 'Bearer $token',
        });
        
        data.forEach((key, value) {
          if (value != null) {
            request.fields[key] = value.toString();
          }
        });
        
        request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
        
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        return _processResponse(response);
      } else {
        final response = await http.patch(
          Uri.parse(ApiConstants.profile),
          headers: await _getHeaders(),
          body: json.encode(data),
        );
        return _processResponse(response);
      }
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.changePassword),
        headers: await _getHeaders(),
        body: json.encode({
          "current_password": currentPassword,
          "new_password": newPassword,
          "confirm_new_password": confirmNewPassword,
        }),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.logout),
        headers: await _getHeaders(),
      );
      await SharedPrefsHelper.clearTokens();
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  // Subscribe to Plan
  static Future<Map<String, dynamic>> subscribeToPlan(int planId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.subscribe),
        headers: await _getHeaders(),
        body: json.encode({
          'plan_id': planId,
          'payment_reference': 'dummy_payment_ref_${DateTime.now().millisecondsSinceEpoch}',
        }),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final response = await http.delete(
        Uri.parse(ApiConstants.deleteAccount),
        headers: await _getHeaders(),
      );
      await SharedPrefsHelper.clearTokens();
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static void _handleException(dynamic e) {
    print('API Error (Profile): $e');
    if (!e.toString().startsWith('Exception: ')) {
      throw Exception('Failed to connect to server.');
    }
  }

  static Map<String, dynamic> _processResponse(http.Response response) {
    print('API Request: ${response.request?.method} ${response.request?.url}');
    print('API Response Status: ${response.statusCode}');
    print('API Response Body: ${response.body}');

    if (response.body.isEmpty) {
       if (response.statusCode >= 200 && response.statusCode < 300) {
         return {'message': 'Success'};
       }
       throw Exception('Error: ${response.statusCode}');
    }
    
    final decoded = json.decode(response.body);
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded is Map ? decoded as Map<String, dynamic> : {'data': decoded};
    } else {
      String errorMsg = 'An error occurred';
      if (decoded is Map) {
        if (decoded.containsKey('errors') && decoded['errors'] is Map) {
          final errors = decoded['errors'] as Map;
          if (errors.containsKey('non_field_errors')) {
            errorMsg = (errors['non_field_errors'] as List).join('\n');
          } else {
            errorMsg = errors.values.first.toString();
          }
        } else if (decoded.containsKey('detail')) {
          errorMsg = decoded['detail'];
        } else if (decoded.containsKey('message')) {
          errorMsg = decoded['message'];
        } else {
          errorMsg = decoded.toString();
        }
      }
      throw Exception(errorMsg);
    }
  }
}
