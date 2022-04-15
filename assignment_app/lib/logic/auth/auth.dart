import 'package:assignment_app/data/models/auth_data_model.dart';
import 'package:assignment_app/utils/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  late final FirebaseAuth _instance;

  Auth() {
    _instance = FirebaseAuth.instance;
  }

  /// For creating user using email and password
  ///
  /// Params : email: String and password: String
  /// On success return [AuthDataModel] class object containing user credentails
  /// On failure return [Failure] class object containing error message
  Future<Either<Failure, AuthDataModel>> signUp(
      {required String email, required String password}) async {
    UserCredential credential;

    try {
      credential = await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.code));
    }

    String? userName = credential.user!.displayName;
    String? userEmail = credential.user!.email;

    return Right(AuthDataModel(userName: '', email: userEmail!));
  }

  /// For authencating existing users using email and password
  ///
  /// Params : email: String and password: String
  /// On success return [AuthDataModel] class object containing user credentails
  /// On failure return [Failure] class object containing error message
  Future<Either<Failure, AuthDataModel>> signIn(
      {required String email, required String password}) async {
    UserCredential credential;

    try {
      credential = await _instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(e.code));
    }

    String? userName = credential.user!.displayName;
    String? userEmail = credential.user!.email;

    return Right(AuthDataModel(userName: '', email: userEmail!));
  }

  /// For checking that is log in or not
  /// return true if user is log in or false if not
  bool isLoggedIn() {
    return _instance.currentUser != null;
  }

  // This is for logging out the user
  Future<void> logOut() async {
    await _instance.signOut();
  }
}
