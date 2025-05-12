import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/session.dart';

class AuthService {
  final _baseUrl = 'http://10.17.35.158:5092';

  Future<Session?> login(String username) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final session = Session(
          username: username,
          sessionId: data['sessionId'],
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('session', jsonEncode(session.toJson()));
        return session;
      } else {
        return null;
      }
    } catch (e) {
      print("Ошибка: $e");
    }
    return null;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
  }

  Future<Session?> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('session');
    if (raw != null) {
      return Session.fromJson(jsonDecode(raw));
    }
    return null;
  }
}
