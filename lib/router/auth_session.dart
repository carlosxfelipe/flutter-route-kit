import 'package:material_ui/material_ui.dart';

class AuthSession extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void signIn() {
    if (_isAuthenticated) return;
    _isAuthenticated = true;
    notifyListeners();
  }

  void signOut() {
    if (!_isAuthenticated) return;
    _isAuthenticated = false;
    notifyListeners();
  }
}
