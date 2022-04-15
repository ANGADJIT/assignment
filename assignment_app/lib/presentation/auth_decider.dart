import 'package:assignment_app/logic/auth/auth.dart';
import 'package:assignment_app/logic/database/session_db.dart';
import 'package:assignment_app/presentation/pages/auth_page.dart';
import 'package:assignment_app/presentation/pages/home.dart';
import 'package:assignment_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthDecider extends StatefulWidget {
  const AuthDecider({Key? key}) : super(key: key);

  @override
  State<AuthDecider> createState() => _AuthDeciderState();
}

class _AuthDeciderState extends State<AuthDecider> {
  late final Auth _auth;
  late final SessionDb _sessionDb;

  Future<void> initialize() async {
    // check for login status
    bool status = _auth.isLoggedIn();

    if (status) {
      _sessionDb.isUserInSession().then((value) {
        if (value) {
          navigateToPageWhileContextBuilding(
              context: context, page: const Home());
        } else {
          _auth.logOut().then((value) {
            navigateToPageWhileContextBuilding(
                context: context, page: const AuthPage());
          });
        }
      });
    } else {
      navigateToPageWhileContextBuilding(
          context: context, page: const AuthPage());
    }
  }

  @override
  void initState() {
    _auth = Auth();
    _sessionDb = SessionDb();
    super.initState();

    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.hexToColor(Vx.whiteHex),
      body: SafeArea(
        child: VStack([
          const Spacer(),
          'Task App'
              .text
              .headline2(context)
              .bold
              .hexColor(Vx.blackHex)
              .makeCentered()
              .py(context.screenHeight * .07),
          CircularProgressIndicator(
            color: Vx.hexToColor('#dafb50'),
            strokeWidth: 5.0,
            backgroundColor: Vx.hexToColor(Vx.whiteHex),
          ).centered().py(context.screenHeight * .01),
          'Checking for session'
              .text
              .light
              .hexColor(Vx.blackHex)
              .makeCentered(),
          const Spacer(),
        ]),
      ),
    );
  }
}
