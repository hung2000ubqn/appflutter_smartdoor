import 'package:appflutter/Screen/Home/home.dart';
import 'package:appflutter/Screen/Wrapper.dart';
import 'package:appflutter/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../MQTT/MQTTAppState.dart';
import '../MQTT/MQTTManager.dart';
import '../Screen/Screen.dart';
import '../Helper/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../Model/user.dart';

/*void main() => runApp(MaterialApp(
  home: Home(),
));*/

/*void main() {
  setupLocator();
  runApp(const MyApp());
}*/
Future <void> main()async{
  setupLocator();
  //await service_locator.allReady();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MQTTManager>(
          create: (context) => service_locator<MQTTManager>()),
        StreamProvider<MyUser?>.value(
          catchError: (_, __) => null,
          value: AuthService().user,
          initialData: null,
          ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          ),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}










