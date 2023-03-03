import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../MQTT/MQTTAppState.dart';
import '../Remote/Test.dart';

class MQTTManager extends ChangeNotifier {
  // Private instance of client
  final MQTTAppState _currentState = MQTTAppState();
  final MqttServerClient _client =
  MqttServerClient.withPort('broker.hivemq.com', 'd907fcce80ca418d9b29fe0c8b8e9e21', 1883);
  String _topic = "hung_boxremote";
  String _topic1 = "flutter_test1";
  var data1;

  void initializeMQTTClient() {
    // Save the values
    _client.keepAlivePeriod = 20;
    _client.secure = false;
    _client.autoReconnect = true;
    _client.pongCallback = pong;
    _client.logging(on: true);

    /// Add the successful connection callback
    _client.onDisconnected = onDisconnected;
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.onUnsubscribed = onUnsubscribed;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('a62f47feaf98421ca37d0b27242f8f6d')
        .authenticateAs("test", "test")
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    _client.connectionMessage = connMess;
  }

  MQTTAppState get currentState => _currentState;
  // Connect to the host
  void connect() async {
    initializeMQTTClient();
    print("try connect to mqtt server");
    assert(_client != null);
    try {
      print('EXAMPLE::Mosquitto start client connecting....');
      _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      updateState();
      await _client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client.disconnect();
  }

  void publish(String message, String topic) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }


  /*int getData() {
    final test = Test.fromJson(data1);
    return test.data;
  }*/


  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
    _currentState
        .setAppConnectionState(MQTTAppConnectionState.connectedSubscribed);
    updateState();
  }

  void onUnsubscribed(String? topic) {
    print('EXAMPLE::onUnsubscribed confirmed for topic $topic');
    _currentState.clearText();
    _currentState
        .setAppConnectionState(MQTTAppConnectionState.connectedUnSubscribed);
    updateState();
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_client.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    _currentState.clearText();
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
    updateState();
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    updateState();
    print('EXAMPLE::Mosquitto client connected....');
    _client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      final payload =
      MqttPublishPayload.bytesToStringAsString(message.payload.message);
      _currentState.setReceivedText(payload);
      updateState();
      print('Received message:$payload from topic: ${c[0].topic}>');
    });
  }


  void subScribeTo(String topic) {
    // Save topic for future use
    _topic = topic;

    try {
      _client.subscribe(topic, MqttQos.atLeastOnce);
    } catch (e) {
      print(e.toString());
    }
  }

  /// Unsubscribe from a topic
  void unSubscribe(String topic) {
    _client.unsubscribe(topic);
  }

  /// Unsubscribe from a topic
  void unSubscribeFromCurrentTopic() {
    _client.unsubscribe(_topic);
    _client.unsubscribe(_topic1);
  }

  void updateState() {
    //controller.add(_currentState);
    notifyListeners();
  }

  void pong() {
    print('Ping response client callback invoked');
  }

  void updateText() {

    notifyListeners();
  }

}