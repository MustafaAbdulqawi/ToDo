abstract class ApiConsumer {
  post({
    required String url,
    required Map<String, dynamic> data,
     Map<String, dynamic>? headers,
  });
}
