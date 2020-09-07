import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_plt/bloc/auth_bloc.dart';
import 'package:multi_plt/repositories/user_model.dart';

class HomePage extends StatelessWidget {
  final UserModel user;

  HomePage({Key key, @required this.user}) : super(key: key);
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
            Text('User: ' + user.name),
            FlatButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
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
