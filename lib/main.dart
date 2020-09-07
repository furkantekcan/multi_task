import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_plt/bloc/auth_bloc/auth_bloc.dart';
import 'package:multi_plt/repositories/auth_repository.dart';
import 'package:multi_plt/screens/error.dart';
import 'package:multi_plt/screens/home_page.dart';
import 'package:multi_plt/screens/loading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthRepository _authRepository = AuthRepository();
  AuthBloc _authBloc;

  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    _authBloc = AuthBloc(authrepository: _authRepository);
    _authBloc.add(AppStarted());
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return ErrorPage();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return BlocProvider(
      create: (BuildContext context) => AuthBloc(
        authrepository: _authRepository,
      ),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthStateBloc>(
          cubit: _authBloc,
          builder: (BuildContext context, AuthStateBloc state) {
            if (state is Uninitialized) {
              return Loading();
            }
            if (state is Authenticated) {
              return HomePage(
                user: state.user,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }
}
