import 'package:d2d_flutter/pages/HomePage.dart';
import 'package:d2d_flutter/pages/LoginPage.dart';
import 'package:d2d_flutter/services/authServices.dart';
import 'package:d2d_flutter/utils/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  Function? superSetState;
  int selectedPosition = 0;

  SignUpPage(Function? superSetState, int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
  }

  @override
  _SignUpScreenState createState() =>
      _SignUpScreenState(this.superSetState, this.selectedPosition);
}

class _SignUpScreenState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Function? superSetState;
  int selectedPosition = 0;

  _SignUpScreenState(Function? superSetState, int selectedPosition) {
    this.superSetState = superSetState;
    this.selectedPosition = selectedPosition;
  }

  Map<String, String> _authData = {'email': '', 'password': ''};
  TextEditingController _passwordController = new TextEditingController();

  Future _submit() async {
    var cState = _formKey.currentState;
    if (cState != null && cState.validate()) {
      //invalid
      return;
    }
    cState?.save();
    try {
      String? email = _authData!['email'];
      String? password = _authData!['password'];
      await Provider.of<Auth>(context, listen: false)
          .signUp(email, password)
          .then((_) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) =>
                HomePage(this.superSetState, this.selectedPosition)));
        Navigator.of(context).pop();
      });
    } on HttpException catch (e) {
      var errorMessage = 'Authentication Failed';
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email is alredy exsist';
        _showerrorDialog(errorMessage);
      } else if (e.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Weak password';
        _showerrorDialog(errorMessage);
      }
    } catch (e) {
      var errorMessage = 'Please Try again later';
      _showerrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(360),
                        bottomRight: Radius.circular(360)),
                    color: Colors.blue),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign up with username or email",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Username or Email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  )),
                              validator: (value) {
                                if (value != null &&
                                    (value.isEmpty || !value.contains('@'))) {
                                  // if (value.isEmpty || !value.contains('@')) {
                                  return 'Invalid email';
                                }
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                  )),
                              validator: (value) {
                                if (value != null &&
                                    (value.isEmpty || value.length < 5)) {
                                  return 'Password is to Short';
                                }
                              },
                              onSaved: (value) {
                                _authData['password'] = value!;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Confirm Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            TextFormField(
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.white,
                                  )),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return 'Password doesnot match';
                                }
                              },
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 40),
                              width: 140,
                              child: RaisedButton(
                                  onPressed: () {
                                    _submit();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.green),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => LoginPage(superSetState, selectedPosition)));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 90),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
