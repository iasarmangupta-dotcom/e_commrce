class AppException implements Exception {
  String title, msg;
  AppException({required this.title, required this.msg});

  @override
  String toString() {
    return "{$title : $msg}";
  }
}

class NoInternetException extends AppException {
  NoInternetException({required String msg})
      : super(title: "No Internet Connection", msg: msg);
}

class BadRequestException extends AppException {
  BadRequestException({required String msg})
      : super(title: "Bad Request", msg: msg);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required String msg})
      : super(title: "Unauthorised", msg: msg);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String msg})
      : super(title: "Invalid Input", msg: msg);
}

class FetchDataException extends AppException {
  FetchDataException({required String msg})
      : super(title: "Error During Communication", msg: msg);
}

class ServerException extends AppException {
  ServerException({required String msg})
      : super(title: "Internal Server Error", msg: msg);
}