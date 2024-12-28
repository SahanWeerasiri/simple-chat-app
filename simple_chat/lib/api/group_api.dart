import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;
import 'package:simple_chat/constants/consts.dart' as con;

class GroupApiService {
  final String baseUrl = '${con.BASE}/api/groups';

  // Create a group
  Future<Map<String, dynamic>> createGroup(int uid, String name) async {
    final url = Uri.parse('$baseUrl/create');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'name': name}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Add group members
  Future<Map<String, dynamic>> addGroupMembers(
      int uid, int groupId, int friendId) async {
    final url = Uri.parse('$baseUrl/add');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'uid': uid, 'group_id': groupId, 'friend_id': friendId}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Get group members
  Future<Map<String, dynamic>> getGroupMembers(int uid, int groupId) async {
    final url = Uri.parse('$baseUrl/member');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'group_id': groupId}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Remove members
  Future<Map<String, dynamic>> removeMembers(
      int uid, int foeId, int groupId) async {
    final url = Uri.parse('$baseUrl/remove');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'foe_id': foeId, 'group_id': groupId}),
      );
      return _processResponse(response);
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }

  // Get groups
  Future<Map<String, dynamic>> getGroups(int uid) async {
    final url = Uri.parse('$baseUrl/group');
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

  // Get group messages
  Future<Map<String, dynamic>> getGroupMsg(int uid, int groupId) async {
    final url = Uri.parse('$baseUrl/msg');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uid': uid, 'group_id': groupId}),
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
      throw Exception(jsonDecode(response.body)['error']);
    }
  }
}
