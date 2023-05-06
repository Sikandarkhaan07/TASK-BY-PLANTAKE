import 'package:plantake/core/apis/get_method.dart';

class Page1Controller {
  static String imageLink = '';

  static Future<void> backgroudImage() async {
    final response = await GetMethod.getImages();
    imageLink = response["results"][0]["urls"]["full"];
  }
}
