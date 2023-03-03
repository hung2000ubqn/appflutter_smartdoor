import 'package:appflutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../MQTT/MQTTManager.dart';
import '../Screen.dart';
import '';


class Home extends StatefulWidget {
  final TextEditingController? id;
  final TextEditingController? idRemote;
  Home ({Key? key,required this.id,required this.idRemote}) : super(key: key);

  @override
  State<Home> createState() => _HomeState(id, idRemote);
}

class _HomeState extends State<Home> {
  final TextEditingController? id;
  final TextEditingController? idRemote;
  _HomeState(this.id, this.idRemote);
  late MQTTManager _manager = MQTTManager();
  //final AuthService _auth = AuthService();

  void ConnectMqtt() {
    Future.delayed(const Duration(microseconds: 100), () => _manager.connect());
    Future.delayed(const Duration(seconds: 4),
            () => _manager.subScribeTo("hung_boxremote"));
    print(_manager.currentState.getAppConnectionState);
  }


  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    Future.delayed(const Duration(microseconds: 300),
            () => _manager.unSubscribeFromCurrentTopic());
    Future.delayed(
        const Duration(microseconds: 600), () => _manager.disconnect());
    super.dispose();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    ConnectMqtt();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _manager = Provider.of<MQTTManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SMART DOOR',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.red,
            fontFamily: 'PTSerif',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
        /*actions: <Widget> [
          ElevatedButton.icon(
            icon: Icon(Icons.people, size: 12),
            label: Text('Sign Out', style: TextStyle(fontSize: 10)),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],*/
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top:18, left:24, right:24),
          child:
          CardControl(
            manager: _manager,
            state_d1: _manager.currentState.getd1,
            state_d2: _manager.currentState.getd2,
            state_d3: _manager.currentState.getd3,
            state_d4: _manager.currentState.getd4,
            id: widget.id!.text,
            idRemote: widget.idRemote!.text,
            textTest: _manager.currentState.getText,
          ),
        ),
      ),
    );
  }
}
