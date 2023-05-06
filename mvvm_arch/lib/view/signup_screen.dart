import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/utils/utility.dart';
import 'package:provider/provider.dart';

import '../resources/components/round_button.dart';
import '../view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                focusNode: _emailFocus,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.email),
                ),
                onFieldSubmitted: (value) {
                  Utility.fieldFocusChange(
                    context,
                    _emailFocus,
                    _passwordFocus,
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _obscurePassword,
                builder: ((context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      label: const Text('Password'),
                      suffixIcon: InkWell(
                        onTap: () {
                          _obscurePassword.value = !_obscurePassword.value;
                        },
                        child: Icon(
                          _obscurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline_sharp),
                    ),
                    obscureText: _obscurePassword.value,
                  );
                }),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              RoundButton(
                  title: 'Sign Up',
                  loading: authViewModel.isLoading,
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utility.flustBarMessage('Please enter email', context);
                    } else if (_passwordController.text.isEmpty) {
                      Utility.flustBarMessage('Please enter password', context);
                    } else if (_passwordController.text.length < 6) {
                      Utility.flustBarMessage(
                          'password must be 6 digit long', context);
                    } else {
                      Map<String, String> data = {
                        "email": _emailController.text,
                        "password": _passwordController.text,
                      };

                      authViewModel.registerApi(data, context);
                      if (kDebugMode) {
                        print('API hit');
                      }
                    }
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.loginScreen);
                },
                child: const Text("Already have an account? Login."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
