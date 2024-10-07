import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app2/modulles/business/business.dart';
import 'package:news_app2/modulles/scinece/scince.dart';
import 'package:news_app2/modulles/sports/sports.dart';
import 'package:news_app2/network/local/cache_helper.dart';
import 'package:news_app2/shared/cubit/states.dart';

import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business_rounded),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_bar_outlined),
      label: 'sports',
    ),
  ];

  List<Widget> screens = [
    const NewsBusinessScreen(),
    const NewsScienceScreen(),
    const NewsSportsScreen(),
  ];

  void newsChangeNavBarState(int index) {
    currentIndex = index;

    if (index == 1) {
      getScience();
    } else {
      getSports();
    }

    emit(NewsChangeBottomNavigationState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    business = [];
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '30cda324605046368e142972e510ac30',
    }).then((value) {
      print(value);
      business = value.data['articles'];
      emit(NewsGetBusinessDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessDataErrorState(error));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    science = [];

    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '30cda324605046368e142972e510ac30',
      }).then((value) {
        print(value);
        science = value.data['articles'];
        emit(NewsGetScienceDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceDataErrorState(error));
      });
    } else {
      emit(NewsGetScienceDataSuccessState());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    sports = [];

    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '30cda324605046368e142972e510ac30',
      }).then((value) {
        print(value);
        sports = value.data['articles'];
        emit(NewsGetSportsDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsDataErrorState(error));
      });
    } else {
      emit(NewsGetSportsDataSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewsGetSearchLoadingState());
    search = [];

    if (search.isEmpty) {
      DioHelper.getData(
          url: 'v2/everything',
          query: {
        'q': '$value',
        'apiKey': '30cda324605046368e142972e510ac30',
      }).then((value) {
        print(value);
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error));
      });
    } else {
      emit(NewsGetSearchSuccessState());
    }
  }

  bool isDark = false;

  void changeAppMode({bool? formShared}) {
    if (formShared != null) {
      isDark = formShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        print(isDark);
        emit(NewsChangeModeState());
      });
    }
  }
}
