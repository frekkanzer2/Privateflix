import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      body: SingleChildScrollView(
        child: Container(
          height: mqd.size.height,
          child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 28, left: 16),
                    width: mqd.size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              "PRIVATEFLIX",
                              style: GoogleFonts.bigShouldersDisplay(
                                textStyle: TextStyle(
                                  color: ColorSoftBlue,
                                ),
                                fontSize: 56,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(child: Container(), flex: 1),
                          ]
                        ),
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                      ],
                    ),
                    color: ColorBlackBlue,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 24, 0),
                    color: ColorBackgroundBlue,
                    child: Column(
                      children: [
                        Expanded(child: Container(), flex: 1),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
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
                                  margin: EdgeInsets.only(bottom: 12),
                                  child: AutoSizeText(
                                    "Prima di inserire un codice di accesso, controlla di essere stato aggiunto come \"collaboratore\" al canale YouTube contenente i materiali.",
                                    maxLines: 4,
                                    minFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: ColorWhite,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 12),
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
                                ),
                              ],
                            ),
                          ),
                          flex: 6,
                        ),
                        Expanded(child: Container(), flex: 1),
                      ]
                    ),
                  ),
                ),
              ],
          ),
        ),
      )
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