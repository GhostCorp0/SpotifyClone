import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_two/domain/usecases/song/get_new_songs.dart';
import 'package:flutter_two/presentation/home/bloc/playlist_state.dart';
import '../../../service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState>{

  PlaylistCubit() : super(PlaylistLoading());

  Future<void> getPlaylist() async{
    var returnedSongs = await sl<GetNewSongsUseCase>().call(null);
    returnedSongs.fold((l){
      emit(PlaylistLoadFailure());
    },(data){
      emit(PlaylistLoaded(songs: data));
    });
  }
}
