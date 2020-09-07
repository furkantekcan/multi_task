import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:multi_plt/repositories/auth_repository.dart';
import 'package:multi_plt/repositories/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStateBloc> {
  final AuthRepository _authrepository;

  //AuthBloc() : super(Uninitialized());

  AuthBloc({@required AuthRepository authrepository})
      : assert(authrepository != null),
        _authrepository = authrepository,
        super(Uninitialized());

  AuthStateBloc get initialState => Uninitialized();

  /*

  class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(WeatherInitial());
  */

  @override
  Stream<AuthStateBloc> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthStateBloc> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authrepository.isSignedIn();
      if (isSignedIn) {
        final UserModel user = await _authrepository.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthStateBloc> _mapLoggedInToState() async* {
    final UserModel user = await _authrepository.getUser();
    yield Authenticated(user);
  }

  Stream<AuthStateBloc> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _authrepository.signOut();
  }
}
