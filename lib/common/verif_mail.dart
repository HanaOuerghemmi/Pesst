import 'package:firebase_auth/firebase_auth.dart';

Future<bool> isEmailAvailable(String email) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: 'password', // Provide a temporary password
    );

    // If registration is successful, email is available
    // But we don't want to actually create a user, so delete the user afterward
    await userCredential.user?.delete();

    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      // Email is already in use
      return false;
    } else {
      // Handle other exceptions
      return false;
    }
  }
}