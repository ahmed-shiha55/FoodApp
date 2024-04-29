import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/screens/mealdetails.dart';
import 'package:foodapp/home_cubit/homecubit.dart';
import 'package:foodapp/home_cubit/homestate.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    TextEditingController searchController = TextEditingController();
    Size screenSize = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: TextField(
            onChanged: (searchController) async {
              await homeCubit.fetchMealsbByLetter(letter: searchController);
            },
            controller: searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        homeCubit.mealserch.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: homeCubit.mealserch.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        await homeCubit.fetchDetailsMeals(
                            id: homeCubit.mealserch[index].idMeal.toString());

                        Navigator.push(
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
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color:
                                      const Color.fromARGB(31, 145, 139, 139)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Image.network(
                                    "${homeCubit.mealserch[index].strMealThumb}",
                                    height: 120,
                                    width: 50,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${homeCubit.mealserch[index].strMeal}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
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
              )
            : searchController.text.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenSize.height / 3,
                      ),
                      Text(
                        " Search with letter ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                : SizedBox()
      ]));
    });
  }
}
