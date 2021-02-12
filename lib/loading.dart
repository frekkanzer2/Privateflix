import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:privateflix/Beans/CategoryBeans.dart';
import 'package:privateflix/Beans/RootBean.dart';
import 'package:privateflix/Beans/VideoBeans.dart';
import 'package:privateflix/Controllers/NetworkingController.dart';
import 'package:privateflix/Utils/Colors.dart';
import 'package:privateflix/Utils/Definitions.dart';
import 'package:privateflix/home.dart';
import 'package:privateflix/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingContents extends StatefulWidget {
  @override
  LoadingContents_State createState() => LoadingContents_State();

  final String registerCode;
  bool autoLogin = false;
  LoadingContents({Key key, @required this.registerCode, this.autoLogin}) : super(key: key);

}

class LoadingContents_State extends State<LoadingContents> {

  List<Category> filmCategories = new List<Category>();
  List<Category> tvSeriesCategories = new List<Category>();
  RootBean packet;
  String submessage = "Sto caricando la libreria...";
  bool isExit = false;

  // ignore: must_call_super
  initState() {
    getDataFromServer();
  }

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mqd = MediaQuery.of(context);

    return Material(
      child: Container(
        padding: EdgeInsets.fromLTRB(60, mqd.size.height * 34 / 100, 60, 0),
        color: ColorSoftBlue,
        child: Column(
          children: [
            Text(
              "PRIVATEFLIX",
              style: GoogleFonts.bigShouldersDisplay(
                textStyle: TextStyle(
                  color: ColorWhite,
                ),
                fontSize: 72,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    color: ColorBlackBlue.withOpacity(0.8),
                    offset: Offset(3, 3),
                    blurRadius: 0.1,
                  ),
                ],
              ),
            ),
            DelayedDisplay(
              child: Container(
                margin: EdgeInsets.only(top: 0),
                child: AutoSizeText(
                  submessage,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorWhite,
                    fontSize: 20,
                  ),
                ),
              ),
              delay: Duration(seconds: 3),
              fadingDuration: Duration(seconds: 1),
            ),
          ],
        ),
      ),
    );
  }

  void getDataFromServer() async {
    bool canChangeRoom = true;
    Timer(
      Duration(
        seconds: 20,
      ),
        // CALLBACK
        () {
          if (!isExit) {
            canChangeRoom = false;
            setState(() {
              submessage = "Non riesco a caricare la libreria!\nVerifica la tua connessione ad internet.";
            });
          }
        }
    );
    String url = NetworkingController.databaseAddress + "/root.json";
    http.Response response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      if (!this.widget.autoLogin) {
        bool canContinue = false;
        int record_index = -1;
        // must check code
        List allCodes = json.decode(response.body)["codes"];
        if (allCodes == null) {
          isExit = true;
          canChangeRoom = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => PrivateFlixHome(external_errorMessage: "Codice non esistente",)
            ), (r) => false,
          );
        } else {
          for (int i = 0; i < allCodes.length; i++)
            if (allCodes[i] == null)
              allCodes.replaceRange(i, i+1, ["nullcode"]);
          for (var _db_code in allCodes) {
            record_index++;
            if (this.widget.registerCode.toLowerCase() ==
                _db_code.toLowerCase()) {
              canContinue = true;
              break;
            }
          }
          if (!canContinue) {
            isExit = true;
            canChangeRoom = false;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => PrivateFlixHome(external_errorMessage: "Codice non esistente",)
              ), (r) => false,
            );
          } else {
            String deleteUrl = NetworkingController.databaseAddress + "/root/codes/" + record_index.toString() + "/.json";
            http.Response response = await http.delete(deleteUrl);
            if (response.statusCode == 200) {
              // add an autologin flag that expires at the end of the month
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool(Definitions.prefs_code, true);
              DateTime today = new DateTime.now();
              await prefs.setInt(Definitions.prefs_month, today.month);
              await prefs.setInt(Definitions.prefs_year, today.year);
            } else {
              SystemNavigator.pop();
            }
          }
        }
      }
      // after code check
      var allFilmCategories = json.decode(response.body)[Definitions.database_allCategoryFilms];
      var allTvSeriesCategories = json.decode(response.body)[Definitions.database_allCategoryTvSeries];
      var tmp_category = null;
      // adding animation films
      List<Video> tmp_videos = new List<Video>();
      tmp_category = allFilmCategories[Definitions.database_category_animation];
      for (var film in tmp_category)
        tmp_videos.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_animation));
      filmCategories.add(Category.newCategory(Definitions.label_category_animation, tmp_videos));
      // adding action / thriller films
      List<Video> tmp_videos2 = new List<Video>();
      tmp_category = allFilmCategories[Definitions.database_category_actionthriller];
      for (var film in tmp_category)
        tmp_videos2.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_actionthriller));
      filmCategories.add(Category.newCategory(Definitions.label_category_actionthriller, tmp_videos2));
      // adding adventure films
      List<Video> tmp_videos3 = new List<Video>();
      tmp_category = allFilmCategories[Definitions.database_category_adventure];
      for (var film in tmp_category)
        tmp_videos3.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_adventure));
      filmCategories.add(Category.newCategory(Definitions.label_category_adventure, tmp_videos3));
      // adding drama films
      List<Video> tmp_videos4 = new List<Video>();
      tmp_category = allFilmCategories[Definitions.database_category_drama];
      for (var film in tmp_category)
        tmp_videos4.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_drama));
      filmCategories.add(Category.newCategory(Definitions.label_category_drama, tmp_videos4));
      // adding comedy films
      List<Video> tmp_videos5 = new List<Video>();
      tmp_category = allFilmCategories[Definitions.database_category_comedy];
      for (var film in tmp_category)
        tmp_videos5.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_comedy));
      filmCategories.add(Category.newCategory(Definitions.label_category_comedy, tmp_videos5));
      // adding fantasy films
      List<Video> tmp_videos6 = new List<Video>();
      tmp_category = allFilmCategories[Definitions.database_category_fantasy];
      for (var film in tmp_category)
        tmp_videos6.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_fantasy));
      filmCategories.add(Category.newCategory(Definitions.label_category_fantasy, tmp_videos6));
      // adding horror films
      List<Video> tmp_videos7 = new List<Video>();
      tmp_category = allFilmCategories[Definitions.database_category_horror];
      for (var film in tmp_category)
        tmp_videos7.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_horror));
      filmCategories.add(Category.newCategory(Definitions.label_category_horror, tmp_videos7));
      // adding animated tv series
      List<Video> tmp_videos8 = new List<Video>();
      tmp_category = allTvSeriesCategories[Definitions.database_category_animatedTvSeries];
      for (var film in tmp_category)
        tmp_videos8.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_animatedTvSeries));
      tvSeriesCategories.add(Category.newCategory(Definitions.label_category_animatedTvSeries, tmp_videos8));
      // adding tv series
      List<Video> tmp_videos9 = new List<Video>();
      tmp_category = allTvSeriesCategories[Definitions.database_category_tvSeries];
      for (var film in tmp_category)
        tmp_videos9.add(new Video(film["title"], film["link"], film["imgurl"], film["head"], Definitions.label_category_tvSeries));
      tvSeriesCategories.add(Category.newCategory(Definitions.label_category_tvSeries, tmp_videos9));
      if (canChangeRoom) {
        isExit = true;
        setState(() {
          submessage = "Ci siamo quasi...";
        });
        Timer(
            Duration(
              seconds: 3,
            ),
            // CALLBACK
            () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(library: new RootBean(filmCategories, tvSeriesCategories))
                ), (r) => false,
              );
            }
        );
      }
    } else {
      if (!isExit)
        setState(() {
          submessage = "Non riesco a caricare la libreria!\nVerifica la tua connessione ad internet.";
        });
    }

  }

}


