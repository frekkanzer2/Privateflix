import 'dart:math';

import 'package:privateflix/Beans/CategoryBeans.dart';
import 'package:privateflix/Beans/VideoBeans.dart';

class RootBean {

  List<Category> films;
  List<Category> series;

  RootBean (List films, List series) {
    this.films = films;
    this.series = series;
  }

  List<Video> getRandomFilms(int howManyVideos){
    List<Video> complete = new List<Video>();
    var generator = new Random();
    for(Category _c in this.films)
      for(Video v in _c.contents)
        complete.add(v);
    List<Video> toReturn = new List<Video>();
    int chosenValue = 0;
    while(toReturn.length < howManyVideos) {
      chosenValue = generator.nextInt(complete.length); // 0 to len-1
      Video picked = complete[chosenValue];
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

  List<Video> getRandomTVSeries(int howManyVideos){
    List<Video> complete = new List<Video>();
    var generator = new Random();
    for(Category _c in this.series)
      for(Video v in _c.contents)
        complete.add(v);
    List<Video> toReturn = new List<Video>();
    int chosenValue = 0;
    while(toReturn.length < howManyVideos) {
      chosenValue = generator.nextInt(complete.length); // 0 to len-1
      Video picked = complete[chosenValue];
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

  List<Category> getRandomCategories(int howManyCategories) {
    List<Category> toReturn = new List<Category>();
    var generator = new Random();
    int choise = 0;
    while (toReturn.length < howManyCategories) {
      choise = generator.nextInt(this.films.length);
      if (toReturn.length == 0) toReturn.add(this.films[choise]);
      else {
        bool canInsert = true;
        for (Category _c in toReturn)
          if (_c.isEqualsTo(this.films[choise])){
            canInsert = false;
            break;
          }
        if (canInsert) toReturn.add(this.films[choise]);
      }
    }
    return toReturn;
  }

  Category getCategoryByName(String categoryName) {
    for (Category c in this.films)
      if (c.name == categoryName) return c;
    for (Category c in this.series)
      if (c.name == categoryName) return c;
    return null;
  }

}