import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privateflix/Beans/CategoryBeans.dart';
import 'package:privateflix/Beans/RootBean.dart';
import 'package:privateflix/Controllers/ButtonsController.dart';
import 'package:privateflix/Utils/Colors.dart';
import 'package:privateflix/Utils/Definitions.dart';

class ChosenSection extends StatefulWidget {

  final Category chosenCategory;
  final RootBean library;

  ChosenSection({Key key, @required this.chosenCategory, @required this.library}) : super(key: key);

  @override
  _ChosenSectionState createState() => _ChosenSectionState();
}

class _ChosenSectionState extends State<ChosenSection> {
  @override
  Widget build(BuildContext context) {

    final MediaQueryData mqd = MediaQuery.of(context);

    return Material(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 62,
          titleSpacing: 8,
          title: Container(
            margin: EdgeInsets.only(top: 6, left: mqd.size.width * 0/100),
            child: Stack(
              children: [
                Text(
                  "PRIVATEFLIX",
                  style: GoogleFonts.bigShouldersDisplay(
                    textStyle: TextStyle(
                      color: ColorSoftBlue,
                    ),
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: mqd.size.width * 83 / 100, bottom: 2),
                  child: IconButton(
                    icon: Icon(
                      Icons.search_rounded,
                      color: ColorWhite,
                      size: 34,
                    ),
                    onPressed: () {
                      print("Pressed search icon");
                    },
                  ),
                )
              ],
            ),
          ),
          backgroundColor: ColorBlackBlue,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: EdgeInsets.only(top: 3, left: 4),
            icon: Icon(FontAwesomeIcons.angleLeft, color: ColorWhite, size: 30,),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: mqd.size.height,
          width: mqd.size.width,
          color: ColorBackgroundBlue,
          padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: mqd.size.width * 1 / 100, bottom: 8),
                  child: AutoSizeText(
                    this.widget.chosenCategory.name,
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorWhite,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  width: mqd.size.width,
                  height: mqd.size.height,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 128/187,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    children: this.widget.chosenCategory.contents.map((value) {
                      return Container(
                          width: mqd.size.width * 30 / 100,
                          height: mqd.size.width * 30 / 100 * (187/128),
                          color: ColorBackgroundBlue,
                          child: FlatButton(
                            onPressed: () {
                              ButtonsController.onPreviewPressed(context, value, this.widget.library);
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              width: mqd.size.width * 30 / 100,
                              height: mqd.size.width * 30 / 100 * (187/128),
                              child: CachedNetworkImage(
                                imageUrl: value.imagelink,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          )
                      );
                    }).toList(),
                  ),
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
            currentIndex: (this.widget.chosenCategory.name == Definitions.label_category_tvSeries ||
                            this.widget.chosenCategory.name == Definitions.label_category_animatedTvSeries) ? 2 : 0,
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
            onTap: (int newIndex) => ButtonsController.onNavButtonPressed(context, this.widget.library, -1, newIndex),
          ),
        ),
      ),
    );
  }
}
