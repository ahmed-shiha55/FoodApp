import 'package:flutter/material.dart';
import 'package:foodapp/model/country.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_flags/country_flags.dart';
import 'package:foodapp/home_cubit/homestate.dart';
import 'package:foodapp/home_cubit/homecubit.dart';
import 'package:foodapp/screens/country_meals.dart';

class Fliter extends StatelessWidget {
  const Fliter({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 250, 139, 28),
            title: const Text(
              'Filter Meals by Country name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          body: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CountryFlag.fromCountryCode(
                  countries[index].code,
                  height: 28,
                  width: 37,
                  borderRadius: 8,
                ),
                title: Text(countries[index].name),
                onTap: () async {
                  await homeCubit.fetchCountryMeals(
                      countryName: countries[index].area);

                  if (homeCubit.countryMeals.isNotEmpty) {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (context) => CountryMealsScreen(
                                CountryName: countries[index].name,
                              )),
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
