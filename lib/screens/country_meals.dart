import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/screens/mealdetails.dart';
import 'package:foodapp/home_cubit/homecubit.dart';

// ignore: must_be_immutable
class CountryMealsScreen extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String CountryName;
  // ignore: non_constant_identifier_names
  CountryMealsScreen({super.key, required this.CountryName});

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 139, 28),
        title: Text(
          "popular meals in $CountryName",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: homeCubit.countryMeals.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              await homeCubit.fetchDetailsMeals(
                  id: homeCubit.countryMeals[index].idMeal.toString());

              Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23),
                        color: const Color.fromARGB(31, 145, 139, 139)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          "${homeCubit.countryMeals[index].strMealThumb}",
                          height: 120,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${homeCubit.countryMeals[index].strMeal}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
