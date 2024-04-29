import 'package:flutter/material.dart';
import 'package:foodapp/model/random.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:foodapp/home_cubit/homecubit.dart';
import 'package:foodapp/home_cubit/homestate.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  DetailsScreen({
    super.key,
  });
  late Meals? meals;

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    var detailsMeal =
        homeCubit.detailsMeals.isNotEmpty ? homeCubit.detailsMeals[0] : null;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_sharp)),
          ),
          body: state is DetailsMealsloading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22)),
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              detailsMeal!.strMealThumb ?? "",
                              fit: BoxFit.fill,
                            )),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                detailsMeal.strMeal ?? "",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.clip),
                              ),
                              Text(detailsMeal.strArea ?? "",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: SizedBox(
                              height: 270,
                              child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Text(
                                      detailsMeal.strInstructions ?? "",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            var youtubeLink = detailsMeal.strYoutube ?? '';

                            // ignore: deprecated_member_use
                            if (await canLaunch(youtubeLink)) {
                              // ignore: deprecated_member_use
                              await launch(youtubeLink);
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Could not launch YouTube link.'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 250, 139, 28),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80.0),
                            child: Text(
                              'Watch on YouTube',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
