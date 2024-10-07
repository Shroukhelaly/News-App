import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app2/network/local/cache_helper.dart';
import 'package:news_app2/network/remote/dio_helper.dart';
import 'package:news_app2/shared/cubit/bloc_observer.dart';
import 'package:news_app2/shared/cubit/cubit.dart';
import 'package:news_app2/shared/cubit/states.dart';

import 'layout/news_home.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();
    DioHelper.init();
    await CacheHelper.init();

    bool? isDark = CacheHelper.getData(key: 'isDark');
    runApp(
      MyApp(isDark),
    );
  }, (error, stack) {
    debugPrint("Global Error: $error");
    debugPrint("Global StackTrace: $stack");
  });
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..changeAppMode(
              formShared: isDark,
            ),
        ),
        BlocProvider(
            create: (BuildContext context) => NewsCubit()..getBusiness())
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  elevation: 0.0,
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
                scaffoldBackgroundColor: Colors.white,
                textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                )),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 10,
                )),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  color: HexColor('#333333'),
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('#333333'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
                scaffoldBackgroundColor: HexColor('#333333'),
                textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('#333333'),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  unselectedIconTheme: const IconThemeData(color: Colors.grey),
                  elevation: 10,
                )),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsHomeScreen(),
          );
        },
      ),
    );
  }
}
