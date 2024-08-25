import 'dart:async';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get isAuthProgress => _isAuthProgress;
  bool get canStartAuth => !_isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Login parolu doldurun';
      notifyListeners();
      return;
    }

    _isAuthProgress = true;
    _errorMessage = null;
    notifyListeners();
    String? sessionId;

    try {
      sessionId = await _apiClient.authenticate(
        username: login,
        password: password,
      );
    } catch (e) {
      _errorMessage = 'Authentication error';
      print('Error: $e');
    }
    _isAuthProgress = false;

    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = "bilinmeyen";
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(
        Navigator.of(context).pushNamed(MainNavigationRouteNames.mainScreen));
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;

  AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
