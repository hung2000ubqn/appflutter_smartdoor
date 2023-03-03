import 'package:appflutter/Screen/Home/home.dart';
import 'package:appflutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/shared/constants.dart';

/*class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();
    final _formKey1 = GlobalKey<FormState>();

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
        actions: <Widget> [
          ElevatedButton.icon(
            icon: Icon(Icons.people, size: 12),
            label: Text('Sign Out', style: TextStyle(fontSize: 10)),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey1,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'ID DOOR'),
                  validator: (val) => val!.isEmpty ? "Enter an id" : null,
                  onChanged: (val) {
                  }
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'ID REMOTE'),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Connect'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              ),
          ],
        ),
      ),
    )
    );
  }
}*/

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _ConnectScreenState extends State<ConnectScreen> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final TextEditingController myIdController = TextEditingController();
  final TextEditingController myIdRemoteController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myIdController.dispose();
    myIdRemoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                controller: myIdController,
                decoration: textInputDecoration.copyWith(hintText: 'ID DOOR'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter an ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: myIdRemoteController,
                decoration: textInputDecoration.copyWith(hintText: 'ID REMOTE'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return null;
                  }
                  return 'It will change the id remote';
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Connect'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home(
                      id: myIdController,
                      idRemote: myIdRemoteController,
                    )),
                  );
                },
              ),
            ],
          ),
        ),
    );
  }
}
