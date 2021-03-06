import "dart:convert";
import 'package:final_620710782/models/api_result.dart';
import 'package:http/http.dart' as http;

class Api {
  static const BASE_URL = 'https://cpsu-test-api.herokuapp.com/quizzes';
  Future<dynamic> fetch(String endPoint, {
    Map<String, dynamic>? queryParams
  }) async {
    var url = Uri.parse('$BASE_URL/$endPoint');
    final response = await http.get(url, headers: {'id': '620710782'});
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);

      var apiResult = ApiResult.fromJson(jsonBody);

      if (apiResult.status == 'ok') {
        return apiResult.data;
      }
      else {
        throw apiResult.message!;
      }
    }
    else {
      throw "Server connection failed";
    }
  }
}
