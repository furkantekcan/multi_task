import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_plt/screens/home_page.dart';
import 'package:multi_plt/services/services.dart';

class LoginPage extends StatefulWidget {
//  LoginPage({Key key, this.title}) : super(key: key);

//  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              onPressed: _pushPage,
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  _pushPage() {
    AuthService().signInWithGoogle().whenComplete(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
    }).catchError((e) => {print('Something wrong')});
  }
}
