import 'package:appflutter/Screen/ConnectScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../MQTT/MQTTManager.dart';

class DoorControl extends StatefulWidget {
  DoorControl(
      {Key? key})
      : super(key: key);
  String textTest = 'NO ACT';
  bool colorChange = false;

  @override
  State<DoorControl> createState() => _DoorControlState();
}

class _DoorControlState extends State<DoorControl> {

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    DateTime now = new DateTime.now();
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 34),
              Center(
                child: Text(
                    '${now.day}/${now.month}/${now.year}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    )
                ),
              ),
              const SizedBox(height: 16),
              Center(
                /*child: Image.asset(
                  'assets/cua_cuon.jpg',
                  height: 200.0,
                  width: 200.0,
                ),*/
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                   'WELCOME TO MY APP',
                    //widget.textTest,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    )
                ),
              ),
              const SizedBox(height: 360),
              Center(
                heightFactor: 2,
                widthFactor: 20,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.settings_remote_outlined, size: 20),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    primary: Colors.deepOrange[400],
                    side: BorderSide(color: Colors.black, width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  ),
                  label: Text('REMOTE', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConnectScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}