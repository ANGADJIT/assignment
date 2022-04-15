import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.hexToColor(Vx.whiteHex),
      appBar: VxAppBar(
        elevation: .0,
        backgroundColor: Vx.hexToColor(Vx.whiteHex),
        title: 'Task App'
            .text
            .headline5(context)
            .bold
            .hexColor('#d9ed80')
            .make(),
      ),
    );
  }
}
