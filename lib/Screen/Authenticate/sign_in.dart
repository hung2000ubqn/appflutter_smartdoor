import 'package:appflutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/Screen/Authenticate/Authenticate.dart';
import 'package:appflutter/shared/constants.dart';

class SignIn extends StatefulWidget {

  final toggleView;
  const SignIn({Key? key, this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authTest = AuthService();
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent[200],
        elevation: 0.0,
        title: Text('Sign In', style: TextStyle(fontSize: 25)),
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.people, size: 12),
            style: ElevatedButton.styleFrom(
              primary: Colors.purpleAccent[200],
            ),
            label: Text('Register', style: TextStyle(fontSize: 11)),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pic3.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        /*child: ElevatedButton(
          child: Text('Sign in anon'),
          onPressed: () async {
            dynamic result = await _authTest.signInAnon();
            if (result == null)
              {
                print('error signing in');
              } else {
                print('sign in');
                print(result.uid);
              }
          },*/
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                }
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _authTest.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'COULD NOT SIGN IN WITH THIS CREDENTIALS';
                      });
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          )
        ),
      ),
    );
  }
}
