import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privateflix/Beans/VideoBeans.dart';
import 'package:privateflix/loading.dart';

import '../videopage.dart';

class ButtonsController {

  static void onRegisterCode(BuildContext context){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => LoadingContents()
        ), (r) => false,
    );
  }

  static void onPreviewPressed(BuildContext context, Video videoPressed) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoDetails(inputVideo: videoPressed)),
    );
  }

  static void onPlayPressed(Video toView) async {
    AndroidIntent intent = AndroidIntent(
      action: "action_view",
      data: toView.videolink
    );
    await intent.launch();
  }

}