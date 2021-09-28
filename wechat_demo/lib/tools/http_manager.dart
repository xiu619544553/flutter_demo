
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpManager {

}

Future<Response> get(Uri url, {Map<String, String>? headers}) {
  return http.get(url, headers: headers);
}