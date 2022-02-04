import 'package:d2d_flutter/BaseHome.dart';
import 'package:d2d_flutter/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(D2DMain());
}

class D2DMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BaseHome(),
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
