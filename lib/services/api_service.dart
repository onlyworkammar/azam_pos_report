import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import '../models/sales_response.dart';

class ApiService {
  static const String baseUrl = 'https://fastapi-app-340110482520.us-central1.run.app/api/v1';

  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(errorBody['error']?['message'] ?? 'Login failed');
    }
  }

  Future<SalesResponse> getSalesWithItems({
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 20,
    String? accessToken,
  }) async {
    final uri = Uri.parse('$baseUrl/sales/with-items');
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };

    if (startDate != null) {
      queryParams['start_date'] = startDate;
    }
    if (endDate != null) {
      queryParams['end_date'] = endDate;
    }

    final url = uri.replace(queryParameters: queryParams);
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return SalesResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      final errorBody = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(errorBody['error']?['message'] ?? 'Failed to fetch sales');
    }
  }
}
