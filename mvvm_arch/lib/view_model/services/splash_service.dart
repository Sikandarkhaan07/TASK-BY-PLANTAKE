// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:mvvm_arch/model/user_model.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/view_model/user_view_model.dart';

class SplashService {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    final user = await getUserData();

    if (user.token == 'null' || user.token == '') {
      Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, RoutesName.loginScreen);
    } else {
      Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
    }
  }
}
