import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_two/common/helpers/is_dark_mode.dart';
import 'package:flutter_two/common/widgets/appbar/app_bar.dart';
import 'package:flutter_two/core/configs/assets/app_images.dart';
import 'package:flutter_two/core/configs/assets/app_vectors.dart';
import 'package:flutter_two/core/configs/theme/app_colors.dart';
import 'package:flutter_two/presentation/home/widgets/news_songs.dart';
import 'package:flutter_two/presentation/home/widgets/play_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,

                children: [NewsSongs(), Container(), Container(), Container()],
              ),
            ),
            PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: Container(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      dividerColor: Colors.transparent,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      controller: _tabController,
      tabs: [
        Text(
          "News",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          "Videos",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          "Artists",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          "Podcasts",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}
