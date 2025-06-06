import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthDataBaseInterface {
  Stream<User?> get authStateChanges;

  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}
