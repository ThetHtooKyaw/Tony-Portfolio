import 'package:flutter/foundation.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isScreenloading = false;
  bool _isActionLoading = false;
  String? _successMessage;
  String? _errorMessage;

  bool get isScreenLoading => _isScreenloading;
  bool get isActionLoading => _isActionLoading;
  String? get successMessage => _successMessage;
  String? get errorMessage => _errorMessage;

  // Screen Loading
  void setScreenLoading(bool value) {
    _isScreenloading = value;
    notifyListeners();
  }

  void startScreenLoading(bool value) {
    _isScreenloading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void stopScreenLoadingWithErrorMessage(String message) {
    _isScreenloading = false;
    _errorMessage = message;
    notifyListeners();
  }

  void stopScreenLoadingWithSuccessMessage(String message) {
    _isScreenloading = false;
    _successMessage = message;
    notifyListeners();
  }

  // Action Loading
  void setActionLoading(bool value) {
    _isActionLoading = value;
    notifyListeners();
  }

  void startActionLoading(bool value) {
    _isActionLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void stopActionLoadingWithErrorMessage(String message) {
    _isActionLoading = false;
    _errorMessage = message;
    notifyListeners();
  }

  void stopActionLoadingWithSuccessMessage(String message) {
    _isActionLoading = false;
    _successMessage = message;
    notifyListeners();
  }

  // Response Handling
  void setSuccess(String? message) {
    _successMessage = message;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
