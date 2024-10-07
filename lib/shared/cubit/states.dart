abstract class NewsStates{}


class NewsInitialState extends NewsStates{}


class NewsBottomNavigationState extends NewsStates{}

class NewsChangeBottomNavigationState extends NewsStates{}

class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessDataSuccessState extends NewsStates{}

class NewsGetBusinessDataErrorState extends NewsStates{

  final String error;
  NewsGetBusinessDataErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceDataSuccessState extends NewsStates{}

class NewsGetScienceDataErrorState extends NewsStates{

  final String error;
  NewsGetScienceDataErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsDataSuccessState extends NewsStates{}

class NewsGetSportsDataErrorState extends NewsStates{

  final String error;
  NewsGetSportsDataErrorState(this.error);
}

class NewsChangeModeState extends NewsStates{}


class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccessState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{

  final String error;
  NewsGetSearchErrorState(this.error);
}


