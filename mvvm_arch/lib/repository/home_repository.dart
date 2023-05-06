import 'package:mvvm_arch/model/Movies_model.dart';

import '../data/network/BaseApiService.dart';
import '../data/network/NetworkApiService.dart';
import '../resources/app_url.dart';

class HomeRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<MovieListModel> getMoviesList() async {
    try {
      dynamic response = await _apiService.getGetApiResponse(
        AppUrl.moviesListUrl,
      );
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
