import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/services/auth.dart';
import 'package:appflutter/Screen/Authenticate/Authenticate.dart';
import 'package:appflutter/shared/constants.dart';

class Register extends StatefulWidget {

  final toggleView;

  const Register({Key? key, this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authTest = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedpasswordController = TextEditingController();
  final fullnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //var email = '';
  //var password = '';
  var error = '';
  //var username = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmedpasswordController.dispose();
    fullnameController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      await _authTest.registerWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      // add user details
      addUserDetails(
        fullnameController.text.trim(),
        emailController.text.trim(),
      );
    }
  }

  Future addUserDetails(String fullName, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Full Name': fullName,
      'Email': email,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() == confirmedpasswordController.text.trim()) {
      return true;
    } else {
      error = 'Confirmed Password is not same as Password';
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent[200],
        elevation: 0.0,
        title: Text('Register', style: TextStyle(fontSize: 25)),
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.people, size: 12),
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent[200],
              ),
            label: Text('Sign In', style: TextStyle(fontSize: 11)),
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
            image: AssetImage("assets/anhnendep.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
            child: Column(
                children: <Widget>[
                  const SizedBox(height: 100.0),
                  TextFormField(
                    controller: fullnameController,
                    decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
                    validator: (val) => val!.isEmpty ? "Enter Full Name" : null,
                    onChanged: (val) {
                      setState(() {
                        //username = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: emailController,
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? "Enter an email" : null,
                    onChanged: (val) {
                      setState(() {
                        //email = val;
                      });
                    }
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        //password = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: confirmedpasswordController,
                    decoration: textInputDecoration.copyWith(hintText: 'Confirmed Password'),
                    validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        //password = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){
                        dynamic result = signUp();
                        if (result == null) {
                          setState(() {
                            error = 'please supply a valid email';
                          });
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  )
                ]
            )
        ),
      ),
    );
  }
}
