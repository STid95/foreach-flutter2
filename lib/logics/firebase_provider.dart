import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseUser = StateProvider<User?>((ref) => null);

final firebaseAuthProvider =
    StateNotifierProvider<FirebaseAuthProvider, FirebaseAuth?>((ref) => FirebaseAuthProvider(ref));

//Je créé une classe qui va maintenir le state et appeler les fonctions définies lorsque je fais ref.watch(videoGameListProvider.notifier)
class FirebaseAuthProvider extends StateNotifier<FirebaseAuth?> {
  Ref ref;
  FirebaseAuthProvider(this.ref) : super(null);
  Future<void> initialize() async {
    state = FirebaseAuth.instance;
    if (state != null) {
      state!.authStateChanges().listen(
        (User? user) {
          print(user);
          if (user == null) {
            print('User null');
            ref.read(firebaseUser.notifier).state = null;
          } else {
            ref.read(firebaseUser.notifier).state = user;
          }
        },
      );
    }
  }

  Future<void> logout() async {
    if (state != null) {
      await state!.signOut();
    }
  }

  Future<void> logIn(String email, String password) async {
    if (state != null) {
      print('log in');
      try {
        final credential = await state!.signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    {
      try {
        await ref.watch(firebaseAuthProvider)?.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
