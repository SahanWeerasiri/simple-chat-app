import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;

class GroupApiService {
  final String baseUrl =
      'http://your-backend-ip-or-domain:port'; // Replace with your backend URL

  // Create a group
  Future<Map<String, dynamic>> createGroup(int uid, String name) async {
    final url = Uri.parse('$baseUrl/create');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'name': name}),
    );
    return _processResponse(response);
  }

  // Add group members
  Future<Map<String, dynamic>> addGroupMembers(
      int uid, int groupId, int friendId) async {
    final url = Uri.parse('$baseUrl/add');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode({'uid': uid, 'group_id': groupId, 'friend_id': friendId}),
    );
    return _processResponse(response);
  }

  // Get group members
  Future<Map<String, dynamic>> getGroupMembers(int uid, int groupId) async {
    final url = Uri.parse('$baseUrl/member');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'group_id': groupId}),
    );
    return _processResponse(response);
  }

  // Remove members
  Future<Map<String, dynamic>> removeMembers(
      int uid, int foeId, int groupId) async {
    final url = Uri.parse('$baseUrl/remove');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'foe_id': foeId, 'group_id': groupId}),
    );
    return _processResponse(response);
  }

  // Get groups
  Future<Map<String, dynamic>> getGroups(int uid) async {
    final url = Uri.parse('$baseUrl/group');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid}),
    );
    return _processResponse(response);
  }

  // Get group messages
  Future<Map<String, dynamic>> getGroupMsg(int uid, int groupId) async {
    final url = Uri.parse('$baseUrl/msg');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'uid': uid, 'group_id': groupId}),
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
