import 'package:dartz/dartz.dart';
import 'package:flutter_two/data/models/auth/create_user_req.dart';
import 'package:flutter_two/data/models/auth/signin_user_req.dart';
import 'package:flutter_two/data/sources/auth/auth_firebase_%20service.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository{

  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseService>().signIn(signinUserReq);
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signUp(createUserReq);
  }

  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<void> signOut() async {
    await sl<AuthFirebaseService>().signOut();
  }
}