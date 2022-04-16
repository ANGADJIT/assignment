import 'package:assignment_app/data/models/auth_data_model.dart';
import 'package:assignment_app/logic/auth/auth.dart';
import 'package:assignment_app/logic/database/session_db.dart';
import 'package:assignment_app/presentation/pages/home.dart';
import 'package:assignment_app/presentation/widgets/button_widget.dart';
import 'package:assignment_app/presentation/widgets/heading_widget.dart';
import 'package:assignment_app/utils/errors.dart';
import 'package:assignment_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthWidget extends StatelessWidget {
  AuthWidget(
      {Key? key,
      required this.isLogin,
      required this.pageContext,
      required this.text})
      : super(key: key);
  final String text;
  final bool isLogin;
  final BuildContext pageContext;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Auth _auth = Auth();
  final SessionDb _sessionDb = SessionDb();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      (context.screenWidth * .3).heightBox,
      const HeadingWidget(),
      text.text.center.semiBold
          .headline6(context)
          .hexColor(Vx.grayHex400)
          .makeCentered()
          .py(context.screenHeight * .04),
      (context.screenWidth * .08).heightBox,
      VxTextField(
        borderColor: Vx.hexToColor(Vx.grayHex300),
        controller: _email,
        clear: false,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        height: context.screenHeight * .07,
        fillColor: Vx.hexToColor(Vx.whiteHex),
        borderType: VxTextFieldBorderType.roundLine,
      ).px(context.screenWidth * .06),
      (context.screenWidth * .03).heightBox,
      VxTextField(
        borderColor: Vx.hexToColor(Vx.grayHex300),
        controller: _password,
        clear: false,
        autofocus: true,
        obscureText: true,
        keyboardType: TextInputType.text,
        height: context.screenHeight * .07,
        fillColor: Vx.hexToColor(Vx.whiteHex),
        borderType: VxTextFieldBorderType.roundLine,
      ).px(context.screenWidth * .06),
      (context.screenWidth * .08).heightBox,

      //
      ButtonWidget(
          buttonText: 'Sign In',
          buttonColor: Vx.hexToColor('#dbfa54'),
          onPressed: () async {
            final String email = _email.text;
            final String password = _password.text;
            Failure failure = Failure('init-failure');
            AuthDataModel authDataModel = AuthDataModel(
              userName: '',
            );

            if (isLogin) {
              await loading('logging in');

              final result =
                  await _auth.signIn(email: email, password: password);
              result.fold((l) => failure = l, (r) => authDataModel = r);

              if (result.isRight()) {
                await _sessionDb.setSession();
                pageContext.nextAndRemoveUntilPage(Home(
                  userName: authDataModel.userName,
                ));
              } else {
                showSnackbar(
                    context: context,
                    message: 'error: ${failure.toString()}',
                    isError: true);
              }
              await loading('', show: false);
            } else {
              await loading('registering...');

              final result =
                  await _auth.signUp(email: email, password: password);
              result.fold((l) => failure = l, (r) => authDataModel = r);

              if (result.isRight()) {
                await _sessionDb.setSession();
                pageContext.nextAndRemoveUntilPage(Home(
                  userName: authDataModel.userName,
                ));
              } else {
                showSnackbar(
                    context: context,
                    message: 'error: ${failure.toString()}',
                    isError: true);
              }
              await loading('', show: false);
            }
          })
    ]);
  }
}
