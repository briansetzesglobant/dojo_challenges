import '../../domain/data_base/auth_data_base_interface.dart';

class AuthController {
  AuthController({required this.authDataBase});

  final AuthDataBaseInterface authDataBase;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await authDataBase.signInWithEmailAndPassword(email, password);
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await authDataBase.createUserWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    await authDataBase.signOut();
  }
}
