import 'package:flutter/material.dart';
import '../MQTT/MQTTManager.dart';

class CardControl extends StatefulWidget {
  CardControl(
      {Key? key,
      required this.manager,
      required this.state_d1,
      required this.state_d2,
      required this.state_d3,
      required this.state_d4,
      required this.id,
      required this.idRemote,
      required this.textTest})
      : super(key: key);
  MQTTManager manager;
  bool state_d1;
  bool state_d2;
  bool state_d3;
  bool state_d4;
  bool colorChange = false;
  final String id;
  final String idRemote;
  String textTest = 'NO ACTION';

  @override
  State<CardControl> createState() => _CardControlState();
}

class _CardControlState extends State<CardControl> {
  // String parse_json_data(int data) {
  //   String jsonData = "";
  //   jsonData = "{\"data\":$data}";
  //   return jsonData;
  // }
  void blinkButton() {
    setState(() {
      widget.colorChange = !widget.colorChange;
    });
  }

  void up() {
    setState(() {
        //textHolder = 'UP';
        print(2);
        upload(widget.id,2,widget.idRemote);
    });

    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void down() {
    setState(() {
        //textHolder = 'DOWN';
        print(3);
        upload(widget.id,3,widget.idRemote);
    });
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void stop() {
    setState(() {
        textHolder = 'STOP';
        print(4);
        upload(widget.id,4,widget.idRemote);
    });

    //  _manager.publish(parse_json_data(get_data_device()),"test");
  }

  void power() {
    setState(() {
      if (widget.state_d4) {
        textHolder = 'POWER ON';
      } else {
        textHolder = 'POWER OFF';
      }
    });
    print(0);
    //print(widget.manager.data);
    //upload(widget.id,get_data_device(),widget.idRemote);
    // _manager.publish(parse_json_data(get_data_device()),"test");
  }

  int get_data_device() {
    int data = 0;
    if (widget.state_d1) {
      data += 1;
    } else {
      data += 0;
    }
    if (widget.state_d2) {
      data += 2;
    } else {
      data += 0;
    }
    if (widget.state_d3) {
      data += 4;
    } else {
      data += 0;
    }
    if (widget.state_d4) {
      data += 8;
    } else {
      data += 0;
    }
    return data;
  }

  String textHolder = 'Door closed';

  void textFunction() {
    //int data = widget.manager.currentState.getdata;
    //widget.manager.currentState.cc();
    print(widget.manager.currentState.getdata);
    //print(widget.manager.currentState.getId);
    setState(() {
      if (widget.state_d1) {
        switch (widget.manager.currentState.getdata) {
          case 0: textHolder = 'POWER ON'; break;
          case 1: textHolder = 'DOOR IS OPENING'; break;
          case 2: textHolder = 'DOOR IS CLOSING'; break;
          case 3: textHolder = 'DOOR IS STOPPED'; break;
          default: textHolder = 'POWER OFF'; break;
        }
      } else {
        textHolder = 'POWER OFF';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  'assets/remote.jpg',
                  height: 200.0,
                  width: 200.0,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                    widget.textTest,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,)),
              ),
              const SizedBox(height: 16),
              const Text(
                'CONTROLLER',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      //textFunction();
                      up();
                      //textHolder = 'UP';
                      //print('1');
                      //upload(widget.id, 1, widget.idRemote);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      width: 156,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          Image.asset('assets/up.png', height: 80, width: 80),
                          const SizedBox(height: 14),
                          Text('UP', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.state_d4 = !widget.state_d4;
                      power();
                      //textFunction();
                      //widget.state_d1 = !widget.state_d1;
                      //print('0');
                      //upload(widget.id, 0, widget.idRemote);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      width: 156,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          Image.asset(
                              'assets/power.png', height: 80, width: 80),
                          const SizedBox(height: 14),
                          Text(
                              'ON/OFF',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      down();
                      //textFunction();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      width: 156,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          Image.asset('assets/down.png', height: 80, width: 80),
                          const SizedBox(height: 14),
                          Text('DOWN', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //textFunction();
                      stop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      width: 156,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          Image.asset('assets/stop.png', height: 80, width: 80),
                          const SizedBox(height: 14),
                          Text('STOP', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  void upload(String id, int data, String idRemote) {
    //String jsonData = "{\"data\":$data}";
    var jsonData = '''{"id": $id,"control_data": $data,"id_remote": $idRemote}''';
  
    try {
      //widget.manager.subScribeTo("hung_appflutter");
      widget.manager.publish(jsonData, "hung_appflutter");
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void retrieve(int data, int doorStatus, int fireStatus, String idRemote) {
    try {
      print(widget.manager.data1);

    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
