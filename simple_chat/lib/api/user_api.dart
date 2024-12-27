import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_chat/constants/consts.dart' as con;

class UserApiService {
  final String baseUrl = '${con.BASE}/api/users';

  // Create new user
  Future<Map<String, dynamic>> createUser(
      String name, String userName, String password) async {
    final url = Uri.parse('$baseUrl/create');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'user_name': userName,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {'status': true, 'data': jsonDecode(response.body)};
      } else {
        throw Exception(
            'Failed to create user: ${jsonDecode(response.body)['error']}');
      }
    } catch (e) {
      return {
        'error': e.toString(),
        'status': false,
      };
    }
  }

  // Sign in
  Future<Map<String, dynamic>> signIn(String userName, String password) async {
    final url = Uri.parse('$baseUrl/signin');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_name': userName,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return {'status': true, 'data': jsonDecode(response.body)['data']};
      } else {
        throw Exception(
            'Failed to sign in: ${jsonDecode(response.body)['error']}');
      }
    } catch (e) {
      return {
        'error': e.toString(),
        'status': false,
      };
    }
  }

  // Sign out
  Future<Map<String, dynamic>> signOut(int uid) async {
    final url = Uri.parse('$baseUrl/signout');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'uid': uid,
        }),
      );

      if (response.statusCode == 200) {
        return {'status': true, 'data': jsonDecode(response.body)};
      } else {
        throw Exception(
            'Failed to sign out: ${jsonDecode(response.body)['error']}');
      }
    } catch (e) {
      return {
        'error': e.toString(),
        'status': false,
      };
    }
  }

  // Update Profile
  Future<Map<String, dynamic>> updateProfile(
      int uid, String name, String img) async {
    final url = Uri.parse('$baseUrl/update');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'uid': uid,
          'name': name,
          'img': img,
        }),
      );

      if (response.statusCode == 200) {
        return {'status': true, 'data': jsonDecode(response.body)};
      } else {
        throw Exception(
            'Failed to update profile: ${jsonDecode(response.body)['error']}');
      }
    } catch (e) {
      return {
        'error': e.toString(),
        'status': false,
      };
    }
  }

  // Get Profile
  Future<Map<String, dynamic>> getProfile(int uid) async {
    final url = Uri.parse('$baseUrl/get');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'uid': uid,
        }),
      );

      if (response.statusCode == 200) {
        return {'status': true, 'data': jsonDecode(response.body)['data']};
      } else {
        throw Exception(
            'Failed to fetch profile: ${jsonDecode(response.body)['error']}');
      }
    } catch (e) {
      return {
        'error': e.toString(),
        'status': false,
      };
    }
  }
}
