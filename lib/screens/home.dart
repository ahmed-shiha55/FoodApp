import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/widget/maincatodry.dart';
import 'package:foodapp/screens/mealdetails.dart';
import 'package:foodapp/home_cubit/homecubit.dart';
import 'package:foodapp/home_cubit/homestate.dart';
import 'package:foodapp/model/PopularIngredients.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is DetailsMealssuceess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15.0),
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),

                    const Text(
                      "Categories ",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    SizedBox(height: 60, child: Cat()),

                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      "Popular Ingredients",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    SizedBox(
                      height: 360,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing:
                              10.0, // Horizontal spacing between columns
                          mainAxisSpacing:
                              10.0, // Vertical spacing between rows
                        ),
                        itemCount: PopularIngredients.imageUrls.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color:
                                      const Color.fromARGB(31, 145, 139, 139)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.network(
                                    PopularIngredients.imageUrls[index],
                                    height: 130,
                                    width: 50, // Adjust the height as needed
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    PopularIngredients.imageDescriptions[index],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Random meals",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    GridView.builder(
                      shrinkWrap: true,
                      // physics: BouncingScrollPhysics(),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: homeCubit.futures.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await homeCubit.fetchDetailsMeals(
                                id: homeCubit.futures[index].idMeal.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: const Color.fromARGB(31, 145, 139, 139)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.network(
                                  "${homeCubit.futures[index].strMealThumb}",
                                  height: 120,
                                  width: 50,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${homeCubit.futures[index].strMeal}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    //),
                  ]),
            ),
          ]),
        );
      },
    );
  }
}
