import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app2/shared/cubit/cubit.dart';
import 'package:news_app2/shared/cubit/states.dart';

import '../../shared/components.dart';

class NewsBusinessScreen extends StatelessWidget {
  const NewsBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (context, states) {

         var list = NewsCubit.get(context).business;
        return ConditionalBuilder(
            condition: states is! NewsGetBusinessLoadingState,
            builder: (context) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BuildArticleItem(list[index]),
                  separatorBuilder: (context, index) => const BuildSeparatorItem(),
                   itemCount: list.length,
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
