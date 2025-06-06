import 'package:firebase_auth/firebase_auth.dart';

import '../../../../domain/data_base/auth_data_base_interface.dart';

class AuthDataBase implements AuthDataBaseInterface {
  AuthDataBase._privateConstructor();

  static final AuthDataBase instance = AuthDataBase._privateConstructor();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();
}
