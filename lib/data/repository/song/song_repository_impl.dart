import 'package:dartz/dartz.dart';
import 'package:flutter_two/data/sources/song/song_firebase_service.dart';
import 'package:flutter_two/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongRepository{
  @override
  Future<Either> getNewSong() {
    return sl<SongFirebaseService>().getNewsSong();
  }

}