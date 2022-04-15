import 'package:assignment_app/presentation/pages/login.dart';
import 'package:assignment_app/presentation/pages/sign_up.dart';
import 'package:assignment_app/presentation/widgets/button_widget.dart';
import 'package:assignment_app/presentation/widgets/heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VStack([
          const Spacer(),
          const HeadingWidget(),
          (context.screenHeight * .15).heightBox,
          ButtonWidget(
              buttonText: 'Register',
              buttonColor: Vx.hexToColor('#dbfa54'),
              onPressed: () {
                context.nextPage(const Register());
              }),
          (context.screenHeight * .04).heightBox,
          ButtonWidget(
              buttonText: 'Sign in',
              buttonColor: Vx.hexToColor(Vx.whiteHex),
              onPressed: () {
                context.nextPage(const Login());
              }),
          const Spacer(),
        ]),
      ),
    );
  }
}
