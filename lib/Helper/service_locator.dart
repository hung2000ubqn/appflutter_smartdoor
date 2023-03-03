import 'package:get_it/get_it.dart';

import '../MQTT/MQTTManager.dart';

GetIt service_locator = GetIt.instance;
void setupLocator() {
  service_locator.registerLazySingleton(() => MQTTManager());
}