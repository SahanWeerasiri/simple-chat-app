import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;
import 'package:simple_chat/constants/consts.dart' as con;

class StatusApiService {
  final String baseUrl =
      '${con.BASE}/api/status'; // Replace with your backend URL

  // Add a status
  Future<Map<String, dynamic>> addStatus(int uid, String msg) async {
    final url = Uri.parse('$baseUrl/add');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'msg': msg}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Delete a status
  Future<Map<String, dynamic>> deleteStatus(int uid, int statusId) async {
    final url = Uri.parse('$baseUrl/delete');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'status_id': statusId}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Get my status
  Future<Map<String, dynamic>> getMyStatus(int uid) async {
    final url = Uri.parse('$baseUrl/getmy');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Get status
  Future<Map<String, dynamic>> getStatus(int uid) async {
    final url = Uri.parse('$baseUrl/get');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Helper function to process response
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return {
        'status': true,
        'data': jsonDecode(response.body)['data'],
        'messege': jsonDecode(response.body)['msg']
      };
    } else {
      throw Exception('Failed API Call: ${jsonDecode(response.body)['error']}');
    }
  }
}
