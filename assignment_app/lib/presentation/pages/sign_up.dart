import 'package:assignment_app/presentation/widgets/auth_widget.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthWidget(
            pageContext: context,
            text: 'Enter your email and set a password',
            isLogin: false));
  }
}
