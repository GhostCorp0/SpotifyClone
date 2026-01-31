

import 'package:dartz/dartz.dart';
import 'package:flutter_two/core/usecase.dart';
import 'package:flutter_two/data/models/auth/signin_user_req.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignInUseCase implements UseCase<Either,SigninUserReq> {
  @override
  Future<Either> call(SigninUserReq? params) async{
    return sl<AuthRepository>().signIn(params!);
  }
}