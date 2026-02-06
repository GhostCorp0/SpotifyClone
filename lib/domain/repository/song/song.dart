import 'package:dartz/dartz.dart';

abstract class SongRepository{
  Future<Either> getNewSong();
  Future<Either>  getPlaylist();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong (String songId);
  Future<Either> getUserFavoriteSongs();
}