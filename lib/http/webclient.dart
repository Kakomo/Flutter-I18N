import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'inteceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()], requestTimeout: Duration(seconds: 5));
final String baseUrl = 'http://192.168.0.60:8080/transactions';
