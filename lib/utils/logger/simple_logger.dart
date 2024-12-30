import 'package:logger/logger.dart';

class CustomLogger {
  final Logger _logger;

  CustomLogger(String className)
      : _logger = Logger(
    printer: _CustomLogPrinter(className),
  );

  void log(Level level, dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(level, message, error: error, stackTrace: stackTrace);
  }

  void debug(dynamic message) => log(Level.debug, message);
  void info(dynamic message) => log(Level.info, message);
  void warning(dynamic message) => log(Level.warning, message);
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      log(Level.error, message, error, stackTrace);
  void verbose(dynamic message) => log(Level.verbose, message);
  void wtf(dynamic message) => log(Level.wtf, message);
}

class _CustomLogPrinter extends LogPrinter {
  final String className;
  final PrettyPrinter _prettyPrinter = PrettyPrinter();

  _CustomLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = _prettyPrinter.levelColors?[event.level];
    final emoji = _prettyPrinter.levelEmojis?[event.level];
    return [color!('$emoji [$className] - ${event.message}')];
  }
}
