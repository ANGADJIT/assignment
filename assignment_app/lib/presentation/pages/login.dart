import 'package:assignment_app/presentation/widgets/auth_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AuthWidget(
            pageContext: context,
        isLogin: true,
        text: 'Enter your email and password for sign in',
      )),
    );
  }
}
