//The original and any copies of the Licensed Programs, made by Licensee, including translations, compilations, partial copies, modifications, and updates, are the property of ARJUN SETH.
//© 2020 ARJUN SETH.All rights reserved.
import 'package:flutter/material.dart';
import 'package:smartmp/Screens/products_overview_screen.dart';

class LoginForm extends StatefulWidget {
  LoginForm(
    this.submitFn,
    this.isLoading,
  );
  final bool isLoading;
  final void Function(
    String email,
    String enrnum,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String pass;
  final _formKey = GlobalKey<FormState>();
  var _isLogin =
      true; //THIS CONTOLS WHETHER YOU ARE IN LOGIN MODE OR SIGNUP MODE.
  var _userEmail = '';
  var _userEnrNum = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context)
        .unfocus();
         //THIS WILL CLOSE THE KEYBOARD ONCE USER HIT THE SUBMIT BUTTON
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _userEmail, _userEnrNum, _userPassword, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (!value.contains('@st.niituniversity.in') ||
                          value.isEmpty) {
                        return 'Please Login With Your University E-Mail ID.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        InputDecoration(labelText: 'University E-Mail ID'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('enrollment number'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Please Login With Your Enrollment Number';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: 'Enrollment Number'),
                      onSaved: (value) {
                        _userEnrNum = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password Must Be Atleast 7 Characters Long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    onSaved: (pass) {
                      _userPassword = pass;
                      
                    },
                    obscureText: true, //PASSWORD SHOULD BE HIDDEN
                  ),
                  SizedBox(height: 12),
                  //if (widget.isLoading) CircularProgressIndicator(),
                  //if (!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    onPressed: _trySubmit,
                    
                  ),
                  //if (!widget.isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'Create New Account'
                        : 'I Already Have An Account.'),
                    onPressed: () {
                      setState(() {
                        //STATE OF THE APP SHOULD BE CHANGED IF USER IS NOT PREVIOUSLY LOGGED IN.
                        _isLogin = !_isLogin;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
}
