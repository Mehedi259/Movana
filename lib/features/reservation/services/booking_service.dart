import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/shared_prefs_helper.dart';

class BookingService {
  static Future<Map<String, String>> _getHeaders() async {
    final token = await SharedPrefsHelper.getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> bookClass(int classId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.bookClass),
        headers: await _getHeaders(),
        body: json.encode({'class_id': classId}),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getCategorizedBookings() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.bookingsStatus),
        headers: await _getHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> cancelBooking(int bookingId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.cancelBooking(bookingId)),
        headers: await _getHeaders(),
      );
      return _processResponse(response);
    } catch (e) {
      _handleException(e);
      rethrow;
    }
  }


  static void _handleException(dynamic e) {
    print('API Error (Booking): $e');
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
        } else if (decoded.containsKey('error')) {
          errorMsg = decoded['error'];
        } else if (decoded.containsKey('message')) {
          errorMsg = decoded['message'];
        }
      }
      throw Exception(errorMsg);
    }
  }
}
