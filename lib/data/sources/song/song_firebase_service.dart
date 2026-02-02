import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_two/domain/entities/song/song.dart';
import 'package:flutter_two/domain/usecases/song/is_favorite_song.dart';

import '../../../service_locator.dart';
import '../../models/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSong();

  Future<Either> getPlaylist();

  Future<Either> addOrRemoveFavoriteSong(String songId);

  Future<bool> isFavoriteSong(String songId);
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
        bool isFavorite  = await sl<IsFavoriteSongUseCase>().call(
          element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
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
        bool isFavorite  = await sl<IsFavoriteSongUseCase>().call(
            element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left("An error occurred, Please try again");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId)async{
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String  uid = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore.collection("Users").doc(uid).collection("Favorites").where('songId',isEqualTo:songId).get();

      if(favoriteSongs.docs.isNotEmpty){
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      }else{
        await firebaseFirestore.collection('Users').doc(uid).collection('Favorites').add({
          'songId':songId,
          'addedDate':Timestamp.now()
        });
        isFavorite = true;
      }
      return Right(isFavorite);
    }catch(e){
      return Left("An error occurred");
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async{
    try{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String  uid = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore.collection("Users").doc(uid).collection("Favorites").where('songId',isEqualTo:songId).get();

      if(favoriteSongs.docs.isNotEmpty){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }
}
