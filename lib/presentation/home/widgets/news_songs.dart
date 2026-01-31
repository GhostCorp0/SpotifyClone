import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_two/domain/entities/song/song.dart';
import 'package:flutter_two/presentation/home/bloc/news_songs_cubit.dart';
import 'package:flutter_two/presentation/home/bloc/news_songs_state.dart';

import '../../../core/configs/constants/app_urls.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(alignment:Alignment.center,child: CircularProgressIndicator());
            }

            if (state is NewsSongsLoaded) {
              return _songs(
                state.songs
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 160,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(image: NetworkImage(AppUrls.fireStorage),fit: BoxFit.cover)
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(width: 14),
      itemCount: songs.length,
    );
  }
}
