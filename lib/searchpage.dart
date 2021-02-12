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

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final Category chosenCategory;
  final RootBean library;

  SearchPage({Key key, @required this.chosenCategory, @required this.library}) : super(key: key);

}

class _SearchPageState extends State<SearchPage> {

  String search = "";
  List<Video> filteredList = new List<Video>();
  bool isSearching = false;

  TextEditingController searchController = new TextEditingController();

  void searchAndFilter(String input) {
    // Getting filtered list from original
    if (input.length >= 3) {
      filteredList = new List<Video>();
      for (Video _v in this.widget.chosenCategory.contents)
        if (_v.name.toLowerCase().contains(input.toLowerCase()))
          filteredList.add(_v);
      setState(() {
        isSearching = true;
      });
    } else {
      setState(() {
        isSearching = false;
      });
    }
  }

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
          padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: mqd.size.width * 1 / 100, bottom: 8),
                  child: AutoSizeText(
                    "Ricerca nella sezione " + this.widget.chosenCategory.name,
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorWhite,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Container(
                  height: 34,
                  margin: EdgeInsets.only(bottom: 18),
                  child: TextFormField(
                    onChanged: (text) {
                      searchAndFilter(text);
                    },
                    controller: searchController,
                    cursorColor: Theme.of(context).cursorColor,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorWhite,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                      hintText: "Cerca un titolo",
                      hintStyle: TextStyle(
                          fontSize: 18,
                          color: ColorSoftGray
                      ),
                      helperStyle: TextStyle(
                          color: ColorSoftGray
                      ),
                      labelStyle: TextStyle(
                        color: ColorSoftGray,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorSoftBlue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorSoftBlue),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorSoftBlue),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorSoftBlue),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: mqd.size.width,
                  height: mqd.size.height * 71 / 100,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 128/187,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    children: filteredList.map((value) {
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
      ),
    );
  }
}
