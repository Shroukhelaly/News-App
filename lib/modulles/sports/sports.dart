import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class NewsSportsScreen extends StatelessWidget {
  const NewsSportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer< NewsCubit, NewsStates>(
      listener: (context, states) {},
      builder: (context, states) {

        var list = NewsCubit.get(context).sports;
        return ConditionalBuilder(
            condition: list.isNotEmpty,
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