import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;

class ContactApiService {
  final String baseUrl =
      'http://your-backend-ip-or-domain:port'; // Replace with your backend URL

  // Get all contacts
  Future<Map<String, dynamic>> getAllContacts(int uid) async {
    final url = Uri.parse('$baseUrl/getall');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid}),
    );
    return _processResponse(response);
  }

  // Get my contacts
  Future<Map<String, dynamic>> getMyContacts(int uid) async {
    final url = Uri.parse('$baseUrl/getmy');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid}),
    );
    return _processResponse(response);
  }

  // Send request
  Future<Map<String, dynamic>> sendRequest(int uid, int friendUid) async {
    final url = Uri.parse('$baseUrl/send');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'friendUid': friendUid}),
    );
    return _processResponse(response);
  }

  // Response to request
  Future<Map<String, dynamic>> responseRequest(
      int uid, int friendUid, String state) async {
    final url = Uri.parse('$baseUrl/response');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'friendUid': friendUid, 'state': state}),
    );
    return _processResponse(response);
  }

  // Show my requests
  Future<Map<String, dynamic>> showMyRequests(int uid) async {
    final url = Uri.parse('$baseUrl/myrequests');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid}),
    );
    return _processResponse(response);
  }

  // Show their requests
  Future<Map<String, dynamic>> showTheirRequests(int uid) async {
    final url = Uri.parse('$baseUrl/theirrequest');
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
