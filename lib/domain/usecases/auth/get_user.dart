import 'package:dartz/dartz.dart';
import 'package:flutter_two/core/usecase.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class GetUserUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call(params) async{
    return await sl<AuthRepository>().getUser();
  }
}