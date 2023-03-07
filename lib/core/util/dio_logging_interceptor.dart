import 'package:dio/dio.dart';
import 'package:neos_post/config/flavor_config.dart';

class DioLoggingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print("--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
      print('Headers:');
      options.headers.forEach((k, v) => print('$k: $v'));
      if (options.queryParameters != null) {
        print('queryParameters:');
        options.queryParameters.forEach((k, v) => print('$k: $v'));
      }
      if (options.data != null) {
        print('Body: ${options.data}');
      }
      print("--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    }

    // example for add header authorization
    /*if (options.headers.containsKey(requiredToken)) {
      options.headers.remove(requiredToken);
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }*/
    return options;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print("<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
      print('Headers:');
      response.headers?.forEach((k, v) => print('$k: $v'));
      print('Response: ${response.data}');
      print('<-- END HTTP');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) async {
    if (FlavorConfig.instance.flavor == Flavor.DEVELOPMENT) {
      print(
          "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response.requestOptions.baseUrl + dioError.response.requestOptions.path) : 'URL')}");
      print("${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
      print('<-- End error');
    }
    return super.onError(dioError, handler);
  }
}
