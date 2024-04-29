class Mealss {
  String? strCategory;

  Mealss({this.strCategory});

  Mealss.fromJson({ required Map<String, dynamic> json}) {
    strCategory = json['strCategory'];
  }

}
