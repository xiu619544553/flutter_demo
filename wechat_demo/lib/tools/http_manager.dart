import 'dart:convert';
import 'package:dio/dio.dart';

/// 网络请求管理类
class HttpManager {

  static final Dio dio = Dio();

  /// get
  Future<HttpResponse> get(String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
  }) async {

    // Options 可以设置头信息、超时等
    final options = Options(headers: headers, receiveTimeout: timeout);

    final response = await dio.get(url,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress);

    return HttpResponse(
        statusCode: response.statusCode ?? -1,
        statusMessage: response.statusMessage ?? '网络请求失败',
        data: response.data);
  }

  // static Future request(String url, {
  //   RequestMethod method = RequestMethod.GET,
  //   Map<String, String>? headers,
  //   Map<String, dynamic>? queryParameters,
  //   ProgressCallback? onReceiveProgress,
  // }) {
  //
  //   // 暂时只封装 get请求
  //   return get(url, headers: headers,
  //       queryParameters: queryParameters,
  //       onReceiveProgress: onReceiveProgress);
  // }
}



/// Response
class HttpResponse<T> {
  HttpResponse({
    this.data,
    required this.statusCode,
    required this.statusMessage,
  });

  T? data;
  int statusCode;
  String statusMessage;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}

/// ----------------------- 分割线 -----------------------
// 网络请求进度回调
typedef ProgressCallback = void Function(int count, int total);

// 网络请求超时时间15秒，单位：毫秒
const int timeout = 15000;

// 接口请求状态码
const int success = 200;
const int failure = -1;

// 请求方式
enum RequestMethod { GET, POST, DELETE, PUT, PATCH, HEAD }

const RequestMethodValues = {
  RequestMethod.GET: "get",
  RequestMethod.POST: "post",
  RequestMethod.DELETE: "delete",
  RequestMethod.PUT: "put",
  RequestMethod.PATCH: "patch",
  RequestMethod.HEAD: "head",
};
