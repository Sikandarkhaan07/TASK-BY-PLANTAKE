import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plantake/core/apis/images_api.dart';

class GetMethod {
  static Future<dynamic> getImages() async {
    final response = await http.get(
      Uri.parse(ImagesAPIs.endPoint),
      headers: {
        'Accept-Version': 'v1',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return Exception('InValid Response.');
    }
  }
}
