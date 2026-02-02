import 'package:flutter_two/core/usecase.dart';
import 'package:flutter_two/domain/repository/song/song.dart';
import '../../../service_locator.dart';

class IsFavoriteSongUseCase  implements UseCase<bool,String> {

  @override
  Future<bool> call(String? params) async{
    return await sl<SongRepository>().isFavoriteSong(params!);
  }
}