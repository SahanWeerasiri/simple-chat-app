import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_chat/constants/consts.dart' as con;

class ContactApiService {
  final String baseUrl = '${con.BASE}/api/contacts';

  // Get all contacts
  Future<Map<String, dynamic>> getAllContacts(int uid) async {
    final url = Uri.parse('$baseUrl/getall');
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

  // Get my contacts
  Future<Map<String, dynamic>> getMyContacts(int uid) async {
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

  // Send request
  Future<Map<String, dynamic>> sendRequest(int uid, int friendUid) async {
    final url = Uri.parse('$baseUrl/send');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'friendUid': friendUid}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Response to request
  Future<Map<String, dynamic>> responseRequest(
      int uid, int friendUid, String state) async {
    final url = Uri.parse('$baseUrl/response');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'friendUid': friendUid, 'state': state}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Show my requests
  Future<Map<String, dynamic>> showMyRequests(int uid) async {
    final url = Uri.parse('$baseUrl/myrequests');
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

  // Remove Contact
  Future<Map<String, dynamic>> removeContact(int uid, int foe_id) async {
    final url = Uri.parse('$baseUrl/remove');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'foeUid': foe_id}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Show their requests
  Future<Map<String, dynamic>> showTheirRequests(int uid) async {
    final url = Uri.parse('$baseUrl/theirrequest');
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
      return {'status': false, 'error': (jsonDecode(response.body)['error'])};
    }
  }
}
