// import 'package:flutter/widgets.dart';

// typedef KeyboardVisibilityChanged = void Function(bool visible);

// class KeyboardVisibilityService with WidgetsBindingObserver {
//   static final KeyboardVisibilityService _instance =
//       KeyboardVisibilityService._internal();
//   factory KeyboardVisibilityService() => _instance;

//   final List<KeyboardVisibilityChanged> _listeners = [];
//   bool _isKeyboardVisible = false;

//   KeyboardVisibilityService._internal() {
//     WidgetsBinding.instance.addObserver(this);
//     _isKeyboardVisible = WidgetsBinding.instance.window.viewInsets.bottom > 0;
//   }

//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _listeners.clear();
//   }

//   bool get isKeyboardVisible => _isKeyboardVisible;

//   void addListener(KeyboardVisibilityChanged listener) {
//     _listeners.add(listener);
//   }

//   void removeListener(KeyboardVisibilityChanged listener) {
//     _listeners.remove(listener);
//   }

//   @override
//   void didChangeMetrics() {
//     final newValue = WidgetsBinding.instance.window.viewInsets.bottom > 0;
//     if (_isKeyboardVisible != newValue) {
//       _isKeyboardVisible = newValue;
//       for (final listener in _listeners) {
//         listener(_isKeyboardVisible);
//       }
//     }
//   }
// }
