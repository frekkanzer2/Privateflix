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

class FilmCategories extends StatefulWidget {
  @override
  _FilmCategoriesState createState() => _FilmCategoriesState();

  final RootBean library;
  FilmCategories({Key key, @required this.library}) : super(key: key);

}

class _FilmCategoriesState extends State<FilmCategories> {

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mqd = MediaQuery.of(context);

    return Material(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 62,
          title: Container(
            margin: EdgeInsets.only(top: 6, left: mqd.size.width * 0 / 100),
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
                      Category filmsCategory = new Category.newCategory(Definitions.label_allCategoryFilms, null);
                      filmsCategory.loadMultipleCategories(this.widget.library.films);
                      ButtonsController.onSearchPressed(context, filmsCategory, this.widget.library);
                    },
                  ),
                )
              ],
            ),
          ),
          backgroundColor: ColorBlackBlue,
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
                for (Category category in this.widget.library.films)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListItem(
                        title: category.name,
                        category: category,
                        rootbean: this.widget.library,
                        onTap: () {
                          ButtonsController.onSameCategoryPressed(context, category, this.widget.library);
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8, bottom: 12),
                        height: 187,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (10 > category.contents.length) ?
                            category.contents.length : 10,
                            itemBuilder: (BuildContext context, int film_index) {
                              return Container(
                                  width: 128,
                                  height: 187,
                                  margin: (film_index != 10-1) ? EdgeInsets.only(right: 12) : EdgeInsets.all(0),
                                  color: ColorBackgroundBlue,
                                  child: FlatButton(
                                    onPressed: () {
                                      ButtonsController.onPreviewPressed(context, category.contents[film_index], this.widget.library);
                                    },
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      width: 128,
                                      height: 187,
                                      child: CachedNetworkImage(
                                        imageUrl: category.contents[film_index].imagelink,
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
              ]
            ),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
              canvasColor: ColorBlackBlue,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: ColorSoftBlue,
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(
                caption: new TextStyle(color: ColorWhite),
              )
          ), // sets the inactive color of the `BottomNavigationBar`
          child: BottomNavigationBar(
            currentIndex: 0,
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
            onTap: (int newIndex) => ButtonsController.onNavButtonPressed(
                context, this.widget.library, 0, newIndex),
          ),
        ),
      ),
    );
  }

}

class ListItem extends StatelessWidget {
  final Function onTap;
  final String title;
  final Category category;
  final RootBean rootbean;
  const ListItem({@required this.onTap, @required this.title,
        @required this.category, @required this.rootbean});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AutoSizeText(
                title,
                maxLines: 1,
                minFontSize: 18,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: ColorWhite,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              IconButton(
                padding: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  FontAwesomeIcons.angleRight,
                  color: ColorSoftBlue,
                  size: 28,
                ),
                onPressed: () {
                  ButtonsController.onSameCategoryPressed(context, category, rootbean);
                },
              ),
            ],
          ),
        ),
    );
  }
}