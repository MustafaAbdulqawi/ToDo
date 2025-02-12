class ErrorInfo {
  final String message;
  final int statusCode;

  ErrorInfo({required this.message, required this.statusCode});
  factory ErrorInfo.fromJson(json) {
    return ErrorInfo(message: json['message'], statusCode: json['statusCode']);
  }
}
