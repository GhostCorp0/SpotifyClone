import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_two/domain/entities/song/song.dart';
import 'package:flutter_two/domain/usecases/song/get_favorite_songs.dart';
import 'package:flutter_two/presentation/profile/bloc/favorite_songs_state.dart';

import '../../../service_locator.dart';

class FavoriteSongsCubit  extends Cubit<FavoriteSongsState>{
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUseCase>().call(null);
    result.fold((l) {
      emit(FavoriteSongsFailure());
    },(favoriteSongs){
      emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
    });
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}