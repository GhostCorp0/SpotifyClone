import 'package:dartz/dartz.dart';
import 'package:flutter_two/core/usecase.dart';
import 'package:flutter_two/data/models/auth/create_user_req.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call(CreateUserReq? params) async {
    return sl<AuthRepository>().signUp(params!);
  }
}
