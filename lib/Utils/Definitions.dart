class Definitions {

  static final String database_root = "root";
  static final String database_allCategoryFilms = "category_film";
  static final String database_allCategoryTvSeries = "category_serietv";
  static final String database_category_animation = "animazione";
  static final String database_category_actionthriller = "azione_thriller";
  static final String database_category_adventure = "avventura";
  static final String database_category_drama = "drammatico";
  static final String database_category_comedy = "commedia";
  static final String database_category_fantasy = "fantascienza";
  static final String database_category_horror = "horror";
  static final String database_category_animatedTvSeries = "serietv_animate";
  static final String database_category_tvSeries = "serietv";
  static final String label_allCategoryFilms = "Film";
  static final String label_allCategoryTvSeries = "Serie TV";
  static final String label_category_animation = "Animazione";
  static final String label_category_actionthriller = "Azione / Thriller";
  static final String label_category_adventure = "Avventura";
  static final String label_category_drama = "Drammatici / Romantici";
  static final String label_category_comedy = "Commedie";
  static final String label_category_fantasy = "Fantascienza";
  static final String label_category_horror = "Horror";
  static final String label_category_animatedTvSeries = "Serie TV Animate";
  static final String label_category_tvSeries = "Serie TV";

  static String getPresentationSentence(String name) {
    if (name == label_category_animation) return "I cartoni non sono per bambini!";
    if (name == label_category_actionthriller) return "Adrenalina pura";
    if (name == label_category_adventure) return "A chi non manca di coraggio";
    if (name == label_category_drama) return "Allarme lacrime!";
    if (name == label_category_comedy) return "Non smettere mai di ridere";
    if (name == label_category_fantasy) return "C'è qualcosa di surreale...";
    if (name == label_category_horror) return "Non adatto ai deboli di cuore";

  }

}