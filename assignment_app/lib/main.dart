import 'package:assignment_app/logic/cubit/tasks_cubit.dart';
import 'package:assignment_app/presentation/auth_decider.dart';
import 'package:assignment_app/presentation/pages/auth_page.dart';
import 'package:assignment_app/presentation/pages/home.dart';
import 'package:assignment_app/presentation/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (context) => TasksCubit(),
      child: MaterialApp(
        title: 'Assignment App',
        debugShowCheckedModeBanner: false,
        home: const AuthDecider(),
        builder: EasyLoading.init(),
        theme: ThemeData(fontFamily: 'Nunito'),
      ),
    );
  }
}
