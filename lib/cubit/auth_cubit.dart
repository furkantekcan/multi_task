import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:multi_plt/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(Uninitialized());

  Future<void> singIn() async {
    try {
      emit(Uninitialized());
      emit(Authenticated());
    } on NetworkException {
      emit(AuthError("Couldn't fetch weather. Is the device online?"));
    }
  }

  Future<void> signOut() async {
    try {
      emit(Uninitialized());
      _authRepository.signOut();
      emit(AuthSignedOut());
    } on NetworkException {
      emit(AuthError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
