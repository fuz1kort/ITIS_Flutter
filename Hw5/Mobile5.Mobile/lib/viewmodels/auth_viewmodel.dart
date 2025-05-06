import 'package:flutter/material.dart';
import '../models/session.dart';
import '../services/amqp_service.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final _amqpService = AmqpService();

  Session? _session;
  String? _message;

  Session? get session => _session;
  String? get message => _message;

  Future<bool> login(String username) async {
    final session = await _authService.login(username);
    if (session != null) {
      _session = session;
      await _listen();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> _listen() async {
    if (_session == null) return;

    await _amqpService.listen(
      session: _session!,
      onLogout: () {
        logout();
      },
      onBroadcast: (msg) {
        _message = msg;
        notifyListeners();
      },
    );
  }

  Future<void> tryRestore() async {
    final restored = await _authService.restoreSession();
    if (restored != null) {
      _session = restored;
      await _listen();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _amqpService.close();
    await _authService.clearSession();
    _session = null;
    notifyListeners();
  }
}
