import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_two/common/widgets/button/basic_app_button.dart';
import 'package:flutter_two/core/configs/assets/app_images.dart';
import 'package:flutter_two/core/configs/assets/app_vectors.dart';
import 'package:flutter_two/core/configs/theme/app_colors.dart';

import '../../choose_mode/choose_mode.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.introBg),
              ),
            ),
          ),
          Container(color: Colors.black.withAlpha(39)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical:40 ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                Spacer(),
                Text(
                  "Enjoy Listening to Music",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 21),
                Text(
                  "Enjoy listening to music.\nLet every beat match your mood",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                BasicAppButton(onPressed:(){
                  Navigator.push(context,MaterialPageRoute(builder:(_)=> ChooseModePage()));
                }, title: "Get Started"),

              ],
            ),
          )
        ],
      ),
    );
  }
}
