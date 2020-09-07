part of 'auth_bloc.dart';

abstract class AuthStateBloc extends Equatable {
  AuthStateBloc([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthStateBloc {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthStateBloc {
  final UserModel user;

  Authenticated(this.user) : super([user]);

  @override
  String toString() => 'Authenticated { displayName: $user }';
}

class Unauthenticated extends AuthStateBloc {
  @override
  String toString() => 'Unauthenticated';
}
