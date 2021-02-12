import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privateflix/Beans/RootBean.dart';
import 'package:privateflix/Beans/VideoBeans.dart';
import 'package:privateflix/Controllers/ButtonsController.dart';
import 'package:privateflix/Utils/Colors.dart';
import 'package:privateflix/Utils/Definitions.dart';

class VideoDetails extends StatefulWidget {

  final Video inputVideo;
  final RootBean packet;

  VideoDetails({Key key, @required this.inputVideo, @required this.packet}) : super(key: key);

  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {

    MediaQueryData mqd = MediaQuery.of(context);
    String type = "";
    if (this.widget.inputVideo.categoryName == Definitions.label_category_tvSeries)
      type = "Playlist della categoria Serie TV";
    else if (this.widget.inputVideo.categoryName == Definitions.label_category_animatedTvSeries)
      type = "Playlist della categoria Serie TV Animate";
    else type = "Film della categoria " + this.widget.inputVideo.categoryName;

    var imageHeight = mqd.size.width / (384/272);

    return Scaffold(
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
      body: Material(
        child: Stack(
          children: [
            Container(
              width: mqd.size.width,
              color: ColorBackgroundBlue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mqd.size.width,
                    height: imageHeight, // setting proportions
                    child: FittedBox(
                      child: CachedNetworkImage(
                        imageUrl: this.widget.inputVideo.headerlink,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: mqd.size.width,
                    height: mqd.size.height * 1.5 / 100,
                    color: ColorBlackBlue,
                    margin: EdgeInsets.only(bottom: mqd.size.width * 2.5 / 100),
                  ),
                  Container(
                    width: mqd.size.width * 80 / 100,
                    padding: EdgeInsets.only(left:mqd.size.width * 3 / 100),
                    child: AutoSizeText(
                      this.widget.inputVideo.name,
                      minFontSize: 14,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: ColorWhite,
                      ),
                    ),
                  ),
                  Divider(
                    height: 14,
                    thickness: 2,
                    color: ColorSoftGray,
                    indent: mqd.size.width * 2.6 / 100,
                    endIndent: mqd.size.width * 18 / 100,
                  ),
                  Container(
                    width: mqd.size.width * 90 / 100,
                    padding: EdgeInsets.only(left:mqd.size.width * 3 / 100),
                    child: AutoSizeText(
                      type,
                      minFontSize: 12,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorWhite,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    width: mqd.size.width * 86 / 100,
                    padding: EdgeInsets.fromLTRB(mqd.size.width * 5 / 100, 12.8, mqd.size.width * 9.5 / 100, 0),
                    margin: EdgeInsets.only(left: mqd.size.width * 3 / 100, bottom: mqd.size.height * 2.8 / 100),
                    height: 50,
                    decoration: new BoxDecoration(
                        color: ColorSoftGray,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(12.0),
                          topRight: const Radius.circular(12.0),
                          bottomLeft: const Radius.circular(12.0),
                          bottomRight: const Radius.circular(12.0),
                        )
                    ),
                    child: AutoSizeText(
                      "Vedi altro della stessa categoria",
                      minFontSize: 16,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: ColorBlackBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: imageHeight - 27, left: mqd.size.width * 78 / 100),
              child: RawMaterialButton(
                onPressed: () => {
                  ButtonsController.onPlayPressed(this.widget.inputVideo),
                },
                elevation: 2.0,
                fillColor: ColorSoftBlue,
                child: Icon(
                  Icons.play_arrow,
                  size: 35.0,
                  color: ColorWhite,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ),
            Container(
              height: mqd.size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  Container(
                    margin: EdgeInsets.only(left: mqd.size.width * 79 / 100, bottom: mqd.size.height * 1.95 / 100),
                    child: RawMaterialButton(
                      onPressed: () => {
                        ButtonsController.onSameCategoryPressed(context, this.widget.packet.getCategoryByName(this.widget.inputVideo.categoryName), this.widget.packet),
                      },
                      elevation: 2.0,
                      fillColor: ColorSoftBlue,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 35.0,
                        color: ColorWhite,
                      ),
                      padding: EdgeInsets.fromLTRB(15, 15, 10, 14),
                      shape: CircleBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
