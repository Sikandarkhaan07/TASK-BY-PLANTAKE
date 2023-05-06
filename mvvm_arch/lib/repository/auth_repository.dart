import 'package:mvvm_arch/data/network/BaseApiService.dart';
import 'package:mvvm_arch/data/network/NetworkApiService.dart';
import 'package:mvvm_arch/resources/app_url.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiService.getPostApiResponse(
        AppUrl.loginUrl,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = await _apiService.getPostApiResponse(
        AppUrl.registerUrl,
        data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
