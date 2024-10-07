import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app2/shared/components.dart';
import 'package:news_app2/shared/cubit/cubit.dart';
import 'package:news_app2/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DefaultTextFormFiled(
                      controller: searchController,
                      type: TextInputType.text,
                      onChanged: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Value Must Not BeEmpty';
                        }
                        return null;
                      },
                      prefix: const Icon(Icons.search_outlined),
                      label: 'Search',
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => BuildArticleItem(list[index]),
                separatorBuilder: (context, index) =>
                    const BuildSeparatorItem(),
                itemCount: list.length,
              ))
            ],
          ),
        );
      },
    );
  }
}
