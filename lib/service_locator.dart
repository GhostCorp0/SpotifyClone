import 'package:flutter_two/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_two/data/repository/song/song_repository_impl.dart';
import 'package:flutter_two/data/sources/auth/auth_firebase_%20service.dart';
import 'package:flutter_two/data/sources/song/song_firebase_service.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';
import 'package:flutter_two/domain/repository/song/song.dart';
import 'package:flutter_two/domain/usecases/auth/get_user.dart';
import 'package:flutter_two/domain/usecases/auth/sign_in.dart';
import 'package:flutter_two/domain/usecases/auth/sign_up.dart';
import 'package:flutter_two/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:flutter_two/domain/usecases/song/get_new_songs.dart';
import 'package:flutter_two/domain/usecases/song/is_favorite_song.dart';
import 'package:get_it/get_it.dart';

import 'domain/usecases/song/get_favorite_songs.dart';
import 'domain/usecases/song/get_play_list.dart';

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

  sl.registerSingleton<GetPlayListUseCase>(
      GetPlayListUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase()
  );

  sl.registerSingleton<IsFavoriteSongUseCase>(
      IsFavoriteSongUseCase()
  );

  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );

  sl.registerSingleton<GetFavoriteSongsUseCase>(
      GetFavoriteSongsUseCase()
  );

}