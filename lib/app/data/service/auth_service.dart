import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/core/utils/toasts.dart';
import 'package:shopywell/app/data/models/user_model.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable user state
  final Rx<User?> user = Rx<User?>(null);
  final Rx<UserModel?> userModel = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    user.bindStream(_auth.authStateChanges());
    ever(user, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) async {
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        userModel.value = UserModel.fromJson(doc.data()!);
      }
    } else {
      userModel.value = null;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if user is disabled

      await _firestore.collection('users').doc(credential.user?.uid).get();

      return credential;
    } catch (e) {
      Toasts.showError(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential?> newUser(
    String email,
    String password,

    String currentUserPassword,
  ) async {
    try {
      // Store current user
      final currentUser = _auth.currentUser;
      final currentEmail = currentUser?.email;

      // Create new user
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        final userModel = UserModel(uid: credential.user!.uid, email: email);

        await createUserDocument(userModel, credential.user!.uid).catchError((
          e,
        ) {
          Toasts.showError('Failed to create user document: ${e.toString()}');
          return null;
        });

        // Sign out the new user
        await _auth.signOut();

        // Sign back in as the original user
        if (currentUser != null && currentEmail != null) {
          try {
            await _auth.signInWithEmailAndPassword(
              email: currentEmail,
              password: currentUserPassword,
            );
          } catch (e) {
            Toasts.showError('Failed to sign back in: ${e.toString()}');
            return null;
          }
        }

        return credential;
      }
      return null;
    } catch (e) {
      Toasts.showError('Failed to create user: ${e.toString()}');
      return null;
    }
  }

  Future<void> createUserDocument(UserModel user, String uid) async {
    await _firestore.collection('users').doc(uid).set(user.toJson());
  }

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user: ${e.toString()}');
      return null;
    }
  }
}
