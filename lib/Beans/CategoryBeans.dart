
import 'dart:math';

import 'package:privateflix/Beans/VideoBeans.dart';

class Category {

  // Instance vars
  String name;
  List<Video> contents;

  // Constructors
  Category.newCategory(this.name, this.contents);

  @override
  String toString() {
    return "CATEGORY: $name";
  }

  bool isEqualsTo(Category another) {
    return (this.name == another.name);
  }

  List<Video> getRandomVideos(int howManyVideos) {
    var generator = new Random();
    List<Video> toReturn = new List<Video>();
    int chosenValue = 0;
    if (this.contents.length < howManyVideos)
      howManyVideos = this.contents.length;
    while(toReturn.length < howManyVideos) {
      chosenValue = generator.nextInt(this.contents.length); // 0 to len-1
      Video picked = this.contents[chosenValue];
      if (toReturn.length == 0) toReturn.add(picked);
      else {
        bool canInsert = true;
        for (Video _v in toReturn)
          if (_v.isEqualsTo(picked)){
            canInsert = false;
            break;
          }
        if (canInsert) toReturn.add(picked);
      }
    }
    return toReturn;
  }

  void loadMultipleCategories(List<Category> categories) {
    if (this.contents == null) {
      this.contents = new List<Video>();
      for (Category _c in categories)
        for(Video v in _c.contents)
          this.contents.add(v);
    }
  }

}

