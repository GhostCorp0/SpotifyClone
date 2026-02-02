import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_two/domain/entities/song/song.dart';

import '../../models/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSong();

  Future<Either> getPlaylist();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSong() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("Songs")
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left("An error occurred, Please try again");
    }
  }

  @override
  Future<Either> getPlaylist() async{
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection("Songs")
          .orderBy('releaseDate', descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left("An error occurred, Please try again");
    }
  }
}
