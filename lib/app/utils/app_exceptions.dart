class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  String toString() {
    return '$_message $_prefix';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message!, 'No Internet!');
}

class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException([String? message])
      : super(message!, 'Request Timeout!');
}

class InternalServerException extends AppExceptions {
  InternalServerException([String? message])
      : super(message!, 'Internal Server Error!');
}


class InvalidDataException extends AppExceptions {
  InvalidDataException([String? message])
      : super(message!, 'Invalid Data Error!');
}


class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? message])
      : super(message!, 'You do not have permission for this!');
}



class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message!, 'Something went wrong! Try later!');
}