import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/logics/firestore_provider.dart';
import 'package:untitled2/models/vg_user.dart';

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

  Future<String?> logIn(String email, String password) async {
    if (state != null) {
      print('log in');
      try {
        final credential = await state!.signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        return (e.message);
      } catch (e) {
        print(e);
      }
      return null;
    }
    return null;
  }

  Future<String?> createUserInFirebase(String email, String password, String favoriteGame) async {
    await signIn(email, password).then((value) {
      if (value != null && value.user != null) {
        print('inscription ok');
        final user = VGUser(id: value.user!.uid, email: email, favoriteGame: favoriteGame);
        ref.read(fireStoreProvider.notifier).createNewUser(user);
      } else
        return 'Inscription ratée';
    }, onError: (error) => 'Inscription ratée');
    return null;
  }

  Future<UserCredential?> signIn(String email, String password) async {
    {
      try {
        return await state!.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        print(e.message);
      } catch (e) {
        print(e);
      }
      return null;
    }
  }
}
