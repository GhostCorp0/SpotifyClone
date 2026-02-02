import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_two/data/models/auth/create_user_req.dart';
import 'package:flutter_two/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserReq createUserReq);

  Future<Either> signIn(SigninUserReq signinUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
      return Right("Signin was successful");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if(e.code == "invalid-email"){
        message = "No user found for that email";
      }else if(e.code == "invalid-credential"){
        message = "Wrong password provided for that user";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      FirebaseFirestore.instance.collection("Users").doc(data.user?.uid).set(
        {
          'name':createUserReq.fullName,
          'email':data.user?.email
        }
      );
      return Right("Signup was successful");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if(e.code == "weak-password"){
        message = "The password provided is too weak";
      }else if(e.code == "email-already-in-use"){
        message = "An account already exists with that email";
      }
      return Left(message);
    }
  }
}