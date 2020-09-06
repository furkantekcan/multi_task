part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class Uninitialized extends AuthState {
  const Uninitialized();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AuthError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
