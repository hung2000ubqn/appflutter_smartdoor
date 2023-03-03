import 'package:appflutter/Screen/ConnectScreen.dart';
import 'package:appflutter/Screen/Home/home.dart';
import 'package:appflutter/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/shared/constants.dart';
import '../MQTT/MQTTManager.dart';
import 'Door.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MainScreenState extends State<MainScreen> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final AuthService _auth = AuthService();
  //final currentUser = FirebaseAuth.instance;
  //final AuthService _auth = AuthService();


  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //final currentUser = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SMART DOOR',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
            fontFamily: 'PTSerif',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
        actions: <Widget> [
          ElevatedButton.icon(
            icon: Icon(Icons.logout, size: 14),
            style: ElevatedButton.styleFrom(
              primary: Colors.white12,
            ),
            label: Text('Sign Out', style: TextStyle(fontSize: 10)),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child:
            DoorControl(),
        ),
      ),
    );
  }
}

