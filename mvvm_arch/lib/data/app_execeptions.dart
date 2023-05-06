// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchAppException extends AppException {
  FetchAppException([String? _message])
      : super(_message, 'Error during communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? _message]) : super(_message, 'Invalid Request');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? _message])
      : super(_message, 'Unauthorised request');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? _message]) : super(_message, 'InValid input');
}
