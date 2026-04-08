import 'package:audify/data/model/auth/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseServices {
  Future<Either> signUp(UserModel userModel);
  Future<Either> signIn(UserModel userModel);
}

class AuthFirebaseServicesImp extends AuthFirebaseServices {
  @override
  Future<Either> signUp(UserModel userModel) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      return Right("Account Register Successfully");
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'weak-password') {
        message = "The password provided is weak";
      } else if (e.code == "email-already-in-use") {
        message = "Email already exist";
      } else if (e.code == "invalid-email") {
        message = "The email address is not formatted correctly.";
      } else if (e.code == "user-disabled") {
        message = "This user has been disabled.";
      }
      return Left(message);
    }
  }

  @override
  Future<Either<dynamic, dynamic>> signIn(UserModel userModel) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      return Right("Login Successfully");
    } on FirebaseAuthException catch (e) {
      // Initialize a default message
      String message = "An unexpected error occurred. Please try again.";

      if (e.code == 'invalid-credential') {
        message = "The email or password you entered is incorrect.";
      } else if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'invalid-email') {
        message = "The email address is not formatted correctly.";
      } else if (e.code == 'user-disabled') {
        message = "This user account has been disabled.";
      } else if (e.code == 'too-many-requests') {
        message = "Too many failed attempts. Please try again later.";
      }

      return Left(message);
    }
  }
}
