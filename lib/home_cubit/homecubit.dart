import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:foodapp/model/random.dart';
import 'package:foodapp/model/catogry1.dart';
import 'package:foodapp/model/country_meal.dart';
import 'package:foodapp/home_cubit/homestate.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Mealss> listCategories = [];
  Future<void> getCategory() async {
    emit(GetcategoryLoadingState());
    Response response = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?c=list"));
    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var item in responseBody['meals']) {
        listCategories.add(Mealss.fromJson(json: item));
      }

      emit(GetcategorySuccessState());
    } else {
      emit(FailedToGetcategoryState());
    }
  }

  List<Meals> listSubCategories = [];
  Future<void> getSubCategory({required String category}) async {
    listSubCategories.clear();
    emit(GetcategoryLoadingState());
    Response response = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category"));
    var responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var item in responseBody['meals']) {
        listSubCategories.add(Meals.fromJson(json: item));
      }

      emit(GetcategorySuccessState());
    } else {
      emit(FailedToGetcategoryState());
    }
  }

  bool data = false;
  // final List<Meals> futures = [];
  // Future<void> fetchRandomMeal() async {
  //   final response = await http
  //       .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

  //   final Map<String, dynamic> data = json.decode(response.body);

  //   if (response.statusCode == 200) {

  //       for (var item in data['meals']) {
  //         futures.add(Meals.fromJson(json: item));
  //         print(futures);

  //     }
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  List<Meals> futures = [];

  fetchRandomMeals() async {
    print("R");
    for (int i = 0; i < 20; i++) {
      final response = await http
          .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        for (var item in data['meals']) {
          // Assuming you have a constructor in your Meals class
          futures.add(Meals.fromJson(json: item));
          print(Meals.fromJson(json: item));

          print("object");
        }
        print(futures[i].idMeal);
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  List<CountryMeals> countryMeals = [];

  fetchCountryMeals({required String countryName}) async {
    countryMeals.clear();
    try {
      emit(CountryMealsLoading());
      countryMeals.clear();

      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?a=$countryName'));
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var item in responseBody['meals']) {
          countryMeals.add(CountryMeals.fromJson(json: item));
        }
        emit(CountryMealsSucess());

        print("daone");
        print(responseBody);
      } else {
        throw Exception('Failed to load meals data');
      }
    } catch (e) {
      emit(CountryMealsFailed());

      print('Error: $e');
    }
  }

  List<Meals> detailsMeals = [];
  fetchDetailsMeals({required id}) async {
    detailsMeals.clear();
    try {
      emit(DetailsMealsloading());
      detailsMeals.clear();

      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));
      var responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in responseBody['meals']) {
          detailsMeals.add(Meals.fromJson(json: item));
        }
        emit(DetailsMealssuceess());
        print("daone");
        print(responseBody);
        print(detailsMeals[0].idMeal);
        print("daone");
      } else {
        throw Exception('Failed to load meals data');
      }
    } catch (e) {
      emit(DetailsMealsFailed());

      print('Error: $e');
    }
  }

  List productDetail = [];

  List<Meals> detailed = [];
  Future<void> DetailtCard(Meals dddd, x) async {
    detailed.clear();
    detailed.add(dddd);
    //products.isAddedToCart = true;
    emit(CountryMealsSucess());
  }

//search by letter
  List<Meals> mealserch = [];

  fetchMealsbByLetter({required String letter}) async {
    mealserch.clear();
    try {
      emit(SearchMealsLoading());
      mealserch.clear();

      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/search.php?f=$letter'));
      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var item in responseBody['meals']) {
          mealserch.add(Meals.fromJson(json: item));
        }
        emit(SearchMealsSucees());

        print("daone");
        print(responseBody);
      } else {
        throw Exception('Failed to load meals data');
      }
    } catch (e) {
      emit(SearchMealsFailed());

      print('Error: $e');
    }
  }
}
