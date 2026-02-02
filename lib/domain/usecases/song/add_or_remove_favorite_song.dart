import 'package:dartz/dartz.dart';
import 'package:flutter_two/core/usecase.dart';
import 'package:flutter_two/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either,String>{

  @override
  Future<Either> call(String params) async{
    return await sl<SongRepository>().addOrRemoveFavoriteSongs(params);
  }
}