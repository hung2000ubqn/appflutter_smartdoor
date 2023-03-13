import 'package:appflutter/Screen/Authenticate/Authenticate.dart';
import 'package:appflutter/Screen/ConnectScreen.dart';
import 'package:appflutter/Screen/Home/home.dart';
import 'package:appflutter/Screen/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<MyUser?>(context);

    //return either mainscreen or authenticate widget
    if (currentUser == null) {
      return Authenticate();
    } else {
      return const MainScreen();
    }
  }
}
