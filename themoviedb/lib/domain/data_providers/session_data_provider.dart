import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const sessionId = 'session-Id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() => _secureStorage.read(key: _Keys.sessionId);
  Future<void> setSessionId(String? value) {
    if (value == null) {
      return _secureStorage.delete(key: _Keys.sessionId);
    } else {
      return _secureStorage.write(key: _Keys.sessionId, value: value);
    }
  }
}
