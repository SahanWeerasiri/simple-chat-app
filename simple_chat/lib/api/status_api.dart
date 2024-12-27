import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;

class StatusApiService {
  final String baseUrl =
      'http://your-backend-ip-or-domain:port'; // Replace with your backend URL

  // Add a status
  Future<Map<String, dynamic>> addStatus(int uid, String msg) async {
    final url = Uri.parse('$baseUrl/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'msg': msg}),
    );
    return _processResponse(response);
  }

  // Delete a status
  Future<Map<String, dynamic>> deleteStatus(int uid, int statusId) async {
    final url = Uri.parse('$baseUrl/delete');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'status_id': statusId}),
    );
    return _processResponse(response);
  }

  // Get my status
  Future<Map<String, dynamic>> getMyStatus(int uid) async {
    final url = Uri.parse('$baseUrl/getmy');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid}),
    );
    return _processResponse(response);
  }

  // Get status
  Future<Map<String, dynamic>> getStatus(int uid) async {
    final url = Uri.parse('$baseUrl/get');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid}),
    );
    return _processResponse(response);
  }

  // Helper function to process response
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed API Call: ${response.body}');
    }
  }
}
