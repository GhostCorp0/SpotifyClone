import 'package:flutter_two/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_two/data/repository/song/song_repository_impl.dart';
import 'package:flutter_two/data/sources/auth/auth_firebase_%20service.dart';
import 'package:flutter_two/data/sources/song/song_firebase_service.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';
import 'package:flutter_two/domain/repository/song/song.dart';
import 'package:flutter_two/domain/usecases/auth/sign_in.dart';
import 'package:flutter_two/domain/usecases/auth/sign_up.dart';
import 'package:flutter_two/domain/usecases/song/get_new_songs.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SongRepository>(
      SongRepositoryImpl()
  );


  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );

  sl.registerSingleton<GetNewSongsUseCase>(
      GetNewSongsUseCase()
  );


}