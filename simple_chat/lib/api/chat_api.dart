import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatApiService {
  final String baseUrl = 'http://localhost:3306/api/chats';

  // Send msg
  Future<Map<String, dynamic>> sendMessege(
      int uid, int friendUid, String msg, String type) async {
    final url = Uri.parse('$baseUrl/send');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'uid': uid, 'friend_uid': friendUid, 'msg': msg, 'type': type}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to send msg: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get msg
  Future<Map<String, dynamic>> getMesseges(
    int uid,
    int friendUid,
  ) async {
    final url = Uri.parse('$baseUrl/get');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'uid': uid,
          'friend_uid': friendUid,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get messeges: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
