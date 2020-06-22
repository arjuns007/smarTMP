//The original and any copies of the Licensed Programs, made by Licensee, including translations, compilations, partial copies, modifications, and updates, are the property of ARJUN SETH.
//© 2020 ARJUN SETH.All rights reserved.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartmp/Widgets/Login_Form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _isLoading = false;
  final _auth = FirebaseAuth
      .instance; //CONNECTION TO FIREBASE SERVERS(MANAGED BY FIREBASE)
  void _submitLoginForm(
    String email,
    String enrnum,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email,
            password:
                password); //THIS RETURNS A FUTURE VALUE WHICH IS SORED IN VARIABLE authResult manges by async and await.
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'Enrollment Number': enrnum,
          'Email': email,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An Error Occured! Please Check Your Credentials.';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    } //HANDLING ERRORS THROWN BY FIREBASE SERVERS
  } //FUNCTION THAT GETS ALL THE DATA FROM LOGIN FORM

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LoginForm(_submitLoginForm, _isLoading),
    );
  }
}
