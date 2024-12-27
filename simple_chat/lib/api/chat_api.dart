import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_chat/constants/consts.dart' as con;

class ChatApiService {
  final String baseUrl = '${con.BASE}/api/chats';

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
        return {'status': true, 'data': jsonDecode(response.body)};
      } else {
        throw Exception('Failed to send msg: ${response.body}');
      }
    } catch (e) {
      return {'status': false, 'error': e.toString()};
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
        return {'status': true, 'data': jsonDecode(response.body)};
      } else {
        throw Exception('Failed to get messeges: ${response.body}');
      }
    } catch (e) {
      return {'status': false, 'error': e.toString()};
    }
  }
}
