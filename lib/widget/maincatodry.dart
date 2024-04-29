import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/home_cubit/homecubit.dart';
import 'package:foodapp/screens/SubCatogryMealsScreen.dart';

class Cat extends StatelessWidget {
  const Cat({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          homeCubit.listCategories.length,
          (index) => InkWell(
            onTap: () async {
              var selectedCategory =
                  homeCubit.listCategories[index].strCategory!.toString();
              await homeCubit.getSubCategory(category: selectedCategory);
              print(selectedCategory);
              // await print(homeCubit.listSubCategories[index]);

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SubCategoryMealsScreen(category: selectedCategory),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 139, 28),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                "${homeCubit.listCategories[index].strCategory ?? " "}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 248, 244, 244),
                ),
              ),
            ),
          ), // <- هنا أضف الفاصلة
        ),
      ),
    );
  }
}
