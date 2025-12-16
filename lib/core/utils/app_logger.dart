import 'dart:developer' as dev;

class AppLogger {
  static void i(String message) {
    dev.log('ℹ️ $message', name: 'AppLogger');
  }

  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      '❌ $message',
      name: 'AppLogger',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
