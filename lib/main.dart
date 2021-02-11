import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privateflix/Controllers/ButtonsController.dart';
import 'package:privateflix/Utils/Colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PrivateFlixHome(),
    );
  }
}

class PrivateFlixHome extends StatefulWidget {
  @override
  _PrivateFlixHomeState createState() => _PrivateFlixHomeState();
}

class _PrivateFlixHomeState extends State<PrivateFlixHome> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mqd = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: Container(
          margin: EdgeInsets.only(top: 28, left: mqd.size.width * 2.2/100),
          child: Text(
            "PRIVATEFLIX",
            style: GoogleFonts.bigShouldersDisplay(
              textStyle: TextStyle(
                color: ColorSoftBlue,
              ),
              fontSize: 56,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: ColorBlackBlue,
      ),
      body: Stack(
        children: [
          Container(
            width: mqd.size.width,
            height: mqd.size.height,
            padding: EdgeInsets.only(left: mqd.size.width * 6/100, right: mqd.size.width * 10/100, bottom: mqd.size.height * 2 / 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: mqd.size.height*12/100, bottom: mqd.size.height*2.5/100),
                    child: AutoSizeText(
                      "Benvenuto!",
                      maxLines: 1,
                      minFontSize: 16,
                      style: TextStyle(
                        fontSize: 32,
                        color: ColorWhite,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: mqd.size.height*4/100),
                    child: AutoSizeText(
                      "Prima di inserire un codice di accesso, controlla di essere stato aggiunto come \"collaboratore\" al canale YouTube contenente i materiali.",
                      maxLines: 3,
                      minFontSize: 16,
                      style: TextStyle(
                        fontSize: 26,
                        color: ColorWhite,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: mqd.size.height * 10 / 100),
                    child: TextFormField(
                      cursorColor: Theme.of(context).cursorColor,
                      maxLength: 14,
                      style: TextStyle(
                        fontSize: 30,
                          color: ColorWhite,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        hintText: "XXXX-XXXX-XXXX",
                        hintStyle: TextStyle(
                          fontSize: 30,
                          color: ColorSoftGray
                        ),
                        helperStyle: TextStyle(
                            color: ColorSoftGray
                        ),
                        icon: Icon(
                          Icons.vpn_key_rounded,
                          color: ColorSoftGray,
                        ),
                        labelStyle: TextStyle(
                          color: ColorSoftGray,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorSoftBlue),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DecoratedBox(
                        decoration:
                        ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            color: ColorSoftBlue
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              buttonTheme: ButtonTheme.of(context).copyWith(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
                          child: OutlineButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Registra",
                              style: TextStyle(
                                color: ColorWhite,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              ButtonsController.onRegisterCode(context);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            color: ColorBackgroundBlue,
          ),
          Container(
            margin: EdgeInsets.only(top: mqd.size.height * 69.8 / 100, left: mqd.size.width * 6.2 / 100),
            child: AutoSizeText(
              "© Francesco Abate · www.fabate.altervista.org",
              minFontSize: 12,
              maxLines: 1,
              style: TextStyle(
                color: ColorWhite,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

}