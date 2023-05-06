import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_arch/model/user_model.dart';
import 'package:mvvm_arch/repository/auth_repository.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/utils/utility.dart';
import 'package:mvvm_arch/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(
    dynamic data,
    BuildContext context,
  ) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);

      final userPref = Provider.of<UserViewModel>(context);
      userPref.saveUser(UserModel(
        token: value['token'].toString(),
      ));
      Utility.flustBarMessage('Login successfully', context);
      Navigator.pushNamed(context, RoutesName.homeScreen);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utility.flustBarMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> registerApi(
    dynamic data,
    BuildContext context,
  ) async {
    setLoading(true);
    _myRepo.registerApi(data).then((value) {
      setLoading(false);
      Utility.flustBarMessage('SignUp successfully', context);
      Navigator.pushNamed(context, RoutesName.homeScreen);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utility.flustBarMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
