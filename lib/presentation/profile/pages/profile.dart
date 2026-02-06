import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_two/common/helpers/is_dark_mode.dart';
import 'package:flutter_two/common/widgets/appbar/app_bar.dart';
import 'package:flutter_two/common/widgets/favorite_button/favorite_button.dart';
import 'package:flutter_two/core/configs/constants/app_urls.dart';
import 'package:flutter_two/core/configs/theme/app_colors.dart';
import 'package:flutter_two/domain/repository/auth/auth.dart';
import 'package:flutter_two/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:flutter_two/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:flutter_two/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:flutter_two/presentation/profile/bloc/profile_info_state.dart';
import 'package:flutter_two/presentation/intro/pages/get_started.dart';
import 'package:flutter_two/service_locator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xff2C2B2B),
      ),
      body: Column(
        children: [
          _profileInfo(context),
          SizedBox(height: 30),
          _favoriteSongs(),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Color(0xff2C2B2B) : Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(state.userEntity.imageUrl!),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(state.userEntity.email!),
                  SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  TextButton(
                    onPressed: () async {
                      await sl<AuthRepository>().signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const GetStarted()),
                          (route) => false,
                        );
                      }
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return Text("Please try again");
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FAVORITE SONGS"),
            SizedBox(height: 20),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return CircularProgressIndicator();
                }

                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      AppUrls.coverFireStorage,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.favoriteSongs[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    state.favoriteSongs[index].artist,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                state.favoriteSongs[index].duration
                                    .toString()
                                    .replaceAll(".", ":"),
                              ),
                              SizedBox(width: 20),
                              FavoriteButton(
                                function: (){
                                  context.read<FavoriteSongsCubit>().removeSong(index);
                                },
                                key: UniqueKey(),
                                songEntity: state.favoriteSongs[index],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return Text("Please try again");
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
