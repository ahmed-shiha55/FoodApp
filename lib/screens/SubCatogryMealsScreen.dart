import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/screens/mealdetails.dart';
import 'package:foodapp/home_cubit/homecubit.dart';
import 'package:foodapp/home_cubit/homestate.dart';

class SubCategoryMealsScreen extends StatelessWidget {
  final String category;
  const SubCategoryMealsScreen({Key? key, required this.category});

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
        } else if (state is DetailsMealsloading) {
          const Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 250, 139, 28),
            elevation: 1,
            title: Text(
              "Sub Category Meals of $category",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: state is GetcategoryLoadingState
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                  ),
                  itemCount: homeCubit.listSubCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        await homeCubit.fetchDetailsMeals(
                          id: homeCubit.listSubCategories[index].idMeal!
                              .toString(),
                        );
                        // Future.delayed(const Duration(seconds: 2));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: const Color.fromARGB(31, 145, 139, 139),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.network(
                                    "${homeCubit.listSubCategories[index].strMealThumb ?? ""}",
                                    height: 120,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${homeCubit.listSubCategories[index].strMeal ?? ""}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
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
      },
    );
  }
}
