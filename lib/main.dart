import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:privateflix/Controllers/ButtonsController.dart';
import 'package:privateflix/Utils/Colors.dart';
import 'package:privateflix/Utils/Definitions.dart';
import 'package:privateflix/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlackLoading(),
    );
  }
}

class BlackLoading extends StatefulWidget {
  @override
  _BlackLoadingState createState() => _BlackLoadingState();
}

class _BlackLoadingState extends State<BlackLoading> {

  void checkAutoLogin() async {
    print("Checking if user has done registration");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasCode = await prefs.getBool(Definitions.prefs_code) ?? false;
    DateTime today = new DateTime.now();
    int m = await prefs.getInt(Definitions.prefs_month) ?? -1;
    int y = await prefs.getInt(Definitions.prefs_year) ?? -1;
    print("Registration values: $hasCode | $m | $y");
    if (m!=-1 && y!=-1 && m == today.month && y == today.year && hasCode) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoadingContents(registerCode: "", autoLogin: true,)
        ), (r) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => PrivateFlixHome()
        ), (r) => false,
      );
    }
  }

  void initState() {
    super.initState();
    checkAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
    );
  }
}


class PrivateFlixHome extends StatefulWidget {

  @override
  _PrivateFlixHomeState createState() => _PrivateFlixHomeState();

  String external_errorMessage = "null";
  PrivateFlixHome({Key key, this.external_errorMessage}) : super(key: key);

}

class _PrivateFlixHomeState extends State<PrivateFlixHome> {

  TextEditingController codeController = new TextEditingController();
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    if (this.widget.external_errorMessage != "null" && this.widget.external_errorMessage != null) {
      this.errorMessage = this.widget.external_errorMessage;
      print(this.widget.external_errorMessage);
    }
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
                      controller: codeController,
                      cursorColor: Theme.of(context).cursorColor,
                      maxLength: 14,
                      style: TextStyle(
                        fontSize: 30,
                          color: ColorWhite,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        hintText: "XXXX-XXXX-XXXX",
                        errorText: errorMessage,
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
                              onRegisterPressed(context, codeController.text);
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
            margin: EdgeInsets.only(top: mqd.size.height * 71.5 / 100, left: mqd.size.width * 6.2 / 100),
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

  void onRegisterPressed(BuildContext context, String code) {
    if (code.length == 14) {
      // length ok
      bool validation = true;
      for (int i = 1; i < 15; i++) {
        if (i % 5 == 0 && code[i-1] != '-') {
          validation = false;
          break;
        } else if (i % 5 != 0 && code[i-1] == '-') {
          validation = false;
          break;
        }
      }
      if (validation) {
        // code string if right, can check on database
        ButtonsController.onRegisterCode(context, code);
      } else {
        // not valid code string
        setState(() {
          errorMessage = "Codice non valido";
        });
      }
    } else {
      // length not right
      setState(() {
        errorMessage = "Codice non valido";
      });
    }
  }

}