import 'package:dartz/dartz.dart';
import 'package:flutter_two/core/usecase.dart';
import 'package:flutter_two/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class GetFavoriteSongsUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call(params) async{
    return await sl<SongRepository>().getUserFavoriteSongs();

  }



}
