import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_two/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:flutter_two/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:flutter_two/domain/entities/song/song.dart';

import '../../../core/configs/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget { 
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({super.key, required this.songEntity, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () async{
                await context.read<FavoriteButtonCubit>().favoriteButtonUpdated(songEntity.songId);
                if(function != null){
                  function!();
                }
              },
              icon: Icon(
                songEntity .isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                color: AppColors.grey,
              ),
            ); 
          }

          if(state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonCubit>().favoriteButtonUpdated(songEntity.songId);
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                color: AppColors.grey,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
