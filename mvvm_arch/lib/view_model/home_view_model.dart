import 'package:flutter/cupertino.dart';
import 'package:mvvm_arch/data/response/api_response.dart';
import 'package:mvvm_arch/model/Movies_model.dart';
import 'package:mvvm_arch/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> getMoviesList() async {
    setMoviesList(
      ApiResponse.loading(),
    );
    myRepo.getMoviesList().then((value) {
      setMoviesList(
        ApiResponse.completed(value),
      );
    }).onError((error, stackTrace) {
      setMoviesList(
        ApiResponse.error(error.toString()),
      );
    });
  }
}
