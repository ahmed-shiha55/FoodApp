import 'package:flutter/material.dart';
import 'package:foodapp/screens/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/home_cubit/homecubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()
            ..fetchRandomMeals()
            ..getCategory(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'API Data Example',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
