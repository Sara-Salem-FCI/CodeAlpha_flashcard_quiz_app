import 'package:flashcard_quiz_app/views/categories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'cubit/categories_cubit/cubit.dart';
import 'cubit/fhashcard_cubit/cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => CategoriesCubit()..createDatabase()),
        BlocProvider(create: (BuildContext context) => FlashCardsCubit()..createDatabase()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const CategoriesView(),
      ),
    );
  }
}
