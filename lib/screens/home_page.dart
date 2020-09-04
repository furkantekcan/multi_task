import 'package:flutter/material.dart';
import 'package:multi_plt/services/services.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Signed in successful'),
            FlatButton(
              onPressed: () {
                AuthService().signOutGoogle();
              },
              child: Text(
                'Sign out',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            )
          ],
        )),
      ),
    );
  }
}
