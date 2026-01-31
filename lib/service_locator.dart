import 'package:flutter_two/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_two/data/sources/auth/auth_firebase_%20service.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';
import 'package:flutter_two/domain/usecases/auth/sign_in.dart';
import 'package:flutter_two/domain/usecases/auth/sign_up.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );

}