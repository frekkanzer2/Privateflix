
import 'package:flutter/material.dart';

class Video {

  // Instance vars
  String name;
  String videolink;
  String imagelink;
  String headerlink;
  String categoryName;

  // Constructors

  Video (String name, String videolink, String imagelink, String headerlink, String categoryName) {
    this.name = name;
    this.videolink = videolink;
    this.imagelink = imagelink;
    this.headerlink = headerlink;
    this.categoryName = categoryName;
    if (this.imagelink == "IMGLINK") this.imagelink = "https://cdn.cinematerial.com/p/297x/haeorwgk/1917-british-movie-poster-md.jpg?v=1579166770";
    if (this.imagelink == "IMGHEAD") this.imagelink = "https://1.bp.blogspot.com/-R2SwyDoOvXI/YCPsg062QBI/AAAAAAAALbw/NKZlIZsZQx4L_VEc8klSNPwra74Qfj95gCLcBGAsYHQ/s320/messiah.png";
  }



  @override
  String toString() {
    return "$name";
  }

  bool isEqualsTo(Video other) {
    return (this.name == other.name);
  }

}

