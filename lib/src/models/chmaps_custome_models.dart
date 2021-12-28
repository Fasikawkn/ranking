abstract class ErrorModels {
  final String message;
  ErrorModels(this.message);
}

class ConnectionError extends ErrorModels {
  ConnectionError(String message) : super(message);
}

class FormatError extends ErrorModels {

  FormatError(String message) : super(message );
}
enum UpcomingMatchStatus {
  loading,
  idle,
  error,
}

class UpcomingMatchReponse<T> {
  final UpcomingMatchStatus modelStatus;
  final T data;
  final ErrorModels? error;

  UpcomingMatchReponse({
    this.error,
    required this.data,
    required this.modelStatus,
  });
}