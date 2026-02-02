import 'package:dartz/dartz.dart';
import 'package:flutter_two/data/sources/song/song_firebase_service.dart';
import 'package:flutter_two/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongRepository{
  @override
  Future<Either> getNewSong() async{
    return await sl<SongFirebaseService>().getNewsSong();
  }

  @override
  Future<Either> getPlaylist() async{
    return await sl<SongFirebaseService>().getPlaylist();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async{
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }
}