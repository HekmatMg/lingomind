import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = 'http://10.0.2.2:8000'}) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    String? bearerToken,
    String? idempotencyKey,
  }) async {
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (bearerToken != null) headers['Authorization'] = 'Bearer $bearerToken';
    if (idempotencyKey != null) headers['Idempotency-Key'] = idempotencyKey;
    final response = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: jsonEncode(body ?? const {}),
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> get(String path, {String? bearerToken}) async {
    final headers = <String, String>{};
    if (bearerToken != null) headers['Authorization'] = 'Bearer $bearerToken';
    final response = await _client.get(Uri.parse('$baseUrl$path'), headers: headers);
    return _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    final dynamic data = response.body.isEmpty ? <String, dynamic>{} : jsonDecode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final detail = data is Map<String, dynamic> ? data['detail'] : null;
      final message = detail is Map<String, dynamic> ? detail['message']?.toString() : 'Request failed.';
      throw ApiException(response.statusCode, message ?? 'Request failed.');
    }
    return data is Map<String, dynamic> ? data : <String, dynamic>{};
  }
}
