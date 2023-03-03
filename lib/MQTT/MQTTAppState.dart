import 'dart:convert';
import 'dart:math';
import '../Remote/Remote.dart';
import '../Remote/Test.dart';

enum MQTTAppConnectionState {
  connected,
  disconnected,
  connecting,
  connectedSubscribed,
  connectedUnSubscribed
}

class MQTTAppState {
  MQTTAppConnectionState _appConnectionState =
      MQTTAppConnectionState.disconnected;
  String _receivedText = '';
  String _historyText = '';
  String idRemote = '';
  String id = '';
  int data = 0;
  int doorStatus = 0;
  int fireStatus = 0;
  bool d1 = false;
  bool d2 = false;
  bool d3 = false;
  bool d4 = false;
  String textTest = 'NO ACT';
  ConvertToBool(int data) {
    if ((data & 1) > 0) {
      d1 = true;
    } else {
      d1 = false;
    }
    if ((data & 2) > 0) {
      d2 = true;
    } else {
      d2 = false;
    }
    if ((data & 4) > 0) {
      d3 = true;
    } else {
      d3 = false;
    }
    if ((data & 8) > 0) {
      d4 = true;
    } else {
      d4 = false;
    }
  }

  void cc(){
    print('test');
  }

  void setReceivedText(var text) {
    //_receivedText = text;
    // _historyText = _historyText + '\n' + _receivedText;
    final json = jsonDecode(text);
    final remote = Remote.fromJson(json);


    idRemote = remote.idRemote;
    //id = test.id;
    //doorStatus = remote.doorStatus;
    fireStatus = remote.fireStatus;
    data = remote.data;
    switch (data) {
      case 2: textTest = 'DOOR IS OPENING'; break;
      case 3: textTest = 'DOOR IS CLOSING'; break;
      case 4: textTest = 'DOOR IS STOPPED'; break;
      default: textTest = 'NO ACTION'; break;
    }
    //ConvertToBool(data);
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
  }

  void clearText() {
    _historyText = "";
    _receivedText = "";
  }

  String get getText => textTest;
  String get getReceivedText => _receivedText;
  String get getHistoryText => _historyText;
  String get getIdRemote => idRemote;
  String get getId => id;
  int get getdata => data;
  int get getDoorStatus => doorStatus;
  int get getFireStatus => fireStatus;
  bool get getd1 => d1;
  bool get getd2 => d2;
  bool get getd3 => d3;
  bool get getd4 => d4;

  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;
}