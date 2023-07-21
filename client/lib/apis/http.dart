import 'dart:convert';

import 'package:chatchat/utils/my_url.dart';
import "package:http/http.dart" as http;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const loginPath = 'api/login';

Future<RequestResult> http_get(String route, [dynamic data]) async
{
  var dataStr = jsonEncode(data);
  //var url = "$my_protocol://$myDomain/$route?data=$dataStr";
  Uri uri = MyUrl(loginPath).getUrl();
  var result = await http.get(uri);
  return RequestResult(true, jsonDecode(result.body));
}
Future<RequestResult> http_post(String route, [dynamic data]) async
{
  Uri uri = MyUrl(loginPath).getUrl();
  var dataStr = jsonEncode(data);
  var result = await http.post(uri, body: dataStr, headers:{"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}
