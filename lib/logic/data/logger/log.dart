import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


final Logger  _logger = Logger(

    printer: PrettyPrinter(
      // levelColors: {
      //   Level.trace: AnsiColor.fg(Colors.grey.value),
      //   Level.debug: AnsiColor.bg(Colors.blue.value),
      //   Level.info: AnsiColor.fg(Colors.green.value),
      //   Level.warning: AnsiColor.fg(Colors.amber.value),
      //   Level.error: AnsiColor.fg(Colors.red[400]?.value),
      //   Level.fatal: AnsiColor.fg(Colors.red[900]?.value),
      // },
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if an error is logged
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print emoji for each log message
        dateTimeFormat: DateTimeFormat.dateAndTime


    )
);

///[extra] is optional parameter to add extra information to the log
extension ConsoleLoggerExtension on Object {
  void logSuccess({String extra = ''}) {
    // Custom log level for error messages with stack trace
    _logger.log(
      Level.trace,
      '${toString()}${extra.isNotEmpty ? '\t\t extra: $extra!' : ''}',
    );
  }

  void logDebug({String extra = ''}) {
    // Custom log level for error messages with stack trace
    _logger.log(
      Level.debug,
      '${toString()}${extra.isNotEmpty ? '\t\t extra: $extra!' : ''}',
    );
  }
  ///[stackTrace] is optional parameter to add stack trace to the log
  void logInfo({String extra = '', StackTrace? stackTrace}) {
    // Custom log level for error messages with stack trace
    _logger.log(Level.info,
        '${toString()}${extra.isNotEmpty ? '\t\t extra: $extra!' : ''}',
        error: this, stackTrace: stackTrace);
  }
  void logWarning({String extra = '', StackTrace? stackTrace}) {
    // Custom log level for error messages with stack trace
    _logger.log(Level.warning,
        '${toString()}${extra.isNotEmpty ? '\t\t extra: $extra!' : ''}',
        error: this, stackTrace: stackTrace);
  }

  void logError({String extra = '', StackTrace? stackTrace}) {
    // Custom log level for error messages with stack trace
    _logger.log(Level.error,
        '${toString()}${extra.isNotEmpty ? '\t\t extra: $extra!' : ''}',
        error: this, stackTrace: stackTrace);
  }
}
