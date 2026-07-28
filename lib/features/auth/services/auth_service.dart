import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/shared_prefs_helper.dart';

class AuthService {
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  /// Register a new user
  static Future<Map<String, dynamic>> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: _headers,
        body: json.encode({
          "email": email,
          "name": name,
          "password": password,
          "password2": passwordConfirm,
        }),
      );

      return _processResponse(response);
    } catch (e, stackTrace) {
      print('API Error: $e');
      if (e.toString().startsWith('Exception: ')) {
        rethrow;
      }
      throw Exception('Failed to connect to server.');
    }
  }

  /// Verify OTP
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.verifyOtp),
        headers: _headers,
        body: json.encode({
          "email": email,
          "otp": otp,
        }),
      );

      return _processResponse(response);
    } catch (e, stackTrace) {
      print('API Error: $e');
      if (e.toString().startsWith('Exception: ')) {
        rethrow;
      }
      throw Exception('Failed to connect to server.');
    }
  }

  /// Login User
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: _headers,
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      final data = _processResponse(response);
      
      // Save token if successful
      if (data.containsKey('access')) {
        await SharedPrefsHelper.saveTokens(
          access: data['access'],
          refresh: data['refresh'],
        );
      }
      return data;
    } catch (e, stackTrace) {
      print('API Error: $e');
      if (e.toString().startsWith('Exception: ')) {
        rethrow;
      }
      throw Exception('Failed to connect to server.');
    }
  }

  /// Forgot Password - Send Email
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.forgetPassword),
        headers: _headers,
        body: json.encode({"email": email}),
      );
      return _processResponse(response);
    } catch (e, stackTrace) {
      print('API Error: $e');
      if (e.toString().startsWith('Exception: ')) {
        rethrow;
      }
      throw Exception('Failed to connect to server.');
    }
  }
  
  /// Helper to process HTTP responses
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
      // Try to extract a meaningful error message
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
