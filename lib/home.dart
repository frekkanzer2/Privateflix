import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privateflix/Beans/CategoryBeans.dart';
import 'package:privateflix/Beans/RootBean.dart';
import 'package:privateflix/Beans/VideoBeans.dart';
import 'package:privateflix/Controllers/ButtonsController.dart';
import 'package:privateflix/Utils/Colors.dart';

class HomePage extends StatefulWidget {

  final RootBean library;

  HomePage({Key key, @required this.library}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isFilmFirst;
  List<Video> randomFilms = new List<Video>();
  List<Video> randomTVSeries = new List<Video>();
  List<Category> randomCategories = new List<Category>();
  int numberOfRandomPreviews = 5;
  int numberOfRandomCategories = 3;

  // ignore: must_call_super
  initState() {
    randomFilms = this.widget.library.getRandomFilms(numberOfRandomPreviews);
    randomTVSeries = this.widget.library.getRandomTVSeries(numberOfRandomPreviews);
    randomCategories = this.widget.library.getRandomCategories(numberOfRandomCategories);
  }

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mqd = MediaQuery.of(context);

    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              toolbarHeight: 62,
              title: Container(
                margin: EdgeInsets.only(top: 6, left: mqd.size.width * 0/100),
                child: Text(
                  "PRIVATEFLIX",
                  style: GoogleFonts.bigShouldersDisplay(
                    textStyle: TextStyle(
                      color: ColorSoftBlue,
                    ),
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              backgroundColor: ColorBlackBlue,
            ),
            body: Container(
              height: mqd.size.height,
              width: mqd.size.width,
              color: ColorBackgroundBlue,
              padding: EdgeInsets.fromLTRB(18, 14, 18, 14),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                    *     Section: suggested films
                    * */
                    AutoSizeText(
                      "Film consigliati",
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorWhite,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 14),
                      height: 187,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: randomFilms.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 128,
                            height: 187,
                            margin: (index != randomFilms.length-1) ? EdgeInsets.only(right: 12) : EdgeInsets.all(0),
                            color: ColorBackgroundBlue,
                              child: FlatButton(
                                  onPressed: () {
                                    ButtonsController.onPreviewPressed(context, randomFilms[index]);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: 128,
                                    height: 187,
                                    child: CachedNetworkImage(
                                      imageUrl: randomFilms[index].imagelink,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                              )
                          );
                        }
                      ),
                    ),
                    /*
                    *     Section: suggested tv series
                    * */
                    AutoSizeText(
                      "Serie TV consigliate",
                      style: TextStyle(
                          fontSize: 20,
                          color: ColorWhite,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 12),
                      height: 187,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: randomTVSeries.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: 128,
                                height: 187,
                                margin: (index != randomTVSeries.length-1) ? EdgeInsets.only(right: 12) : EdgeInsets.all(0),
                                color: ColorBackgroundBlue,
                                child: FlatButton(
                                  onPressed: () {
                                    ButtonsController.onPreviewPressed(context, randomTVSeries[index]);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: 128,
                                    height: 187,
                                    child: CachedNetworkImage(
                                      imageUrl: randomTVSeries[index].imagelink,
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                          CircularProgressIndicator(value: downloadProgress.progress),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                )
                            );
                          }
                      ),
                    ),
                    /*
                    *     RANDOM CATEGORIES
                    * */
                    for (int category_index = 0; category_index < numberOfRandomCategories; category_index++)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            randomCategories[category_index].name,
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorWhite,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, bottom: 12),
                            height: 187,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (numberOfRandomPreviews > randomCategories[category_index].contents.length) ?
                                                randomCategories[category_index].contents.length : numberOfRandomPreviews,
                                itemBuilder: (BuildContext context, int film_index) {
                                  return Container(
                                      width: 128,
                                      height: 187,
                                      margin: (film_index != numberOfRandomPreviews-1) ? EdgeInsets.only(right: 12) : EdgeInsets.all(0),
                                      color: ColorBackgroundBlue,
                                      child: FlatButton(
                                        onPressed: () {
                                          ButtonsController.onPreviewPressed(context, randomCategories[category_index].contents[film_index]);
                                        },
                                        padding: EdgeInsets.zero,
                                        child: Container(
                                          width: 128,
                                          height: 187,
                                          child: CachedNetworkImage(
                                            imageUrl: randomCategories[category_index].contents[film_index].imagelink,
                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                CircularProgressIndicator(value: downloadProgress.progress),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      )
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: ColorBlackBlue,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: ColorSoftBlue,
                textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(color: ColorWhite),
                )
              ), // sets the inactive color of the `BottomNavigationBar`
              child: BottomNavigationBar(
                currentIndex: 1,
                items: [
                  BottomNavigationBarItem(
                    icon: new Icon(FontAwesomeIcons.video),
                    label: 'Film',
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(FontAwesomeIcons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.photoVideo),
                      label: 'Serie TV',
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: mqd.size.width * 86 / 100, top: mqd.size.height * 4.7 / 100),
            child: IconButton(
              icon: Icon(
                Icons.search_rounded,
                color: ColorWhite,
                size: 38,
              ),
              onPressed: () {
                print("Pressed search icon");
              },
            ),
          )
        ],
      ),
    );
  }
}
