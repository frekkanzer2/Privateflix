import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privateflix/Beans/CategoryBeans.dart';
import 'package:privateflix/Beans/RootBean.dart';
import 'package:privateflix/Beans/VideoBeans.dart';
import 'package:privateflix/filmsections.dart';
import 'file:///D:/Workspaces/Github/Privateflix/lib/sectionpage.dart';
import 'package:privateflix/home.dart';
import 'package:privateflix/loading.dart';
import 'package:privateflix/searchpage.dart';
import 'package:privateflix/tvseriesections.dart';

import '../videopage.dart';

class ButtonsController {

  static void onRegisterCode(BuildContext context, String code){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoadingContents(registerCode: code, autoLogin: false,)
        ), (r) => false,
    );
  }

  static void onPreviewPressed(BuildContext context, Video videoPressed, RootBean packet) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoDetails(inputVideo: videoPressed, packet: packet,)),
    );
  }

  static void onPlayPressed(Video toView) async {
    AndroidIntent intent = AndroidIntent(
      action: "action_view",
      data: toView.videolink
    );
    await intent.launch();
  }

  static void onSameCategoryPressed(BuildContext context, Category chosen, RootBean library) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChosenSection(chosenCategory: chosen, library: library)),
    );
  }

  static void onNavButtonPressed(BuildContext context, RootBean library, int actualIndex, int pressedIndex) {
    switch (pressedIndex) {
      case 0:
        if (pressedIndex != actualIndex) onFilmPressed(context, library);
        break;
      case 1:
        if (pressedIndex != actualIndex) onHomePressed(context, library);
        break;
      case 2:
        if (pressedIndex != actualIndex) onTVSeriesPressed(context, library);
        break;
    }
  }
  
  static void onFilmPressed(BuildContext context, RootBean library) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => FilmCategories(library: library)
      ), (r) => false,
    );
  }
  
  static void onHomePressed(BuildContext context, RootBean library) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(library: library)
      ), (r) => false,
    );
  }
  
  static void onTVSeriesPressed(BuildContext context, RootBean library) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => TVSeriesCategories(library: library)
      ), (r) => false,
    );
  }

  static void onSearchPressed(BuildContext context, Category category, RootBean library) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage(chosenCategory: category, library: library)),
    );
  }

}