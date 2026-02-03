import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_two/common/widgets/appbar/app_bar.dart';
import 'package:flutter_two/core/configs/constants/app_urls.dart';
import 'package:flutter_two/core/configs/theme/app_colors.dart';
import 'package:flutter_two/presentation/song_player/bloc/song_player_cubit.dart';
import '../../../common/widgets/favorite_button/favorite_button.dart';
import '../../../domain/entities/song/song.dart';
import '../bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;

  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text("Now Playing", style: TextStyle(fontSize: 18)),
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(AppUrls.songFireStorage),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              _songCover(context),
              SizedBox(height: 20),
              _songDetail(),
              SizedBox(height: 20),
              _songPlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(AppUrls.coverFireStorage),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              songEntity.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ],
        ),
        FavoriteButton(songEntity:songEntity)
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return CircularProgressIndicator();
        }

        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds

                    .toDouble(),
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition,
                    ),
                  ),
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap:(){
                   context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child:Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing?Icons.pause:Icons.play_arrow
                  ),
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) { 
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")} ';
  }
}
