import 'package:d2d_flutter/pages/HomePage.dart';
import 'package:d2d_flutter/pages/LoginPage.dart';
import 'package:d2d_flutter/pages/SplashPage.dart';
import 'package:d2d_flutter/services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(Main());
}

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //home: LoginPage(),
    );
  }
}

/**
 * with login page
 */
/*
class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Auth(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //auth.isAuth it coming from auth.dart
          home: auth.isAuth
              ? HomePage()
              : FutureBuilder(
            future: auth.tryautoLogin(),
            builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? SplashPage()
                : LoginPage(),
          ),
        ),
      ),
    );
  }
}
*/
