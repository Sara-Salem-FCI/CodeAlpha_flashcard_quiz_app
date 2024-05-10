import 'package:flashcard_quiz_app/cubit/fhashcard_cubit/cubit.dart';
import 'package:flashcard_quiz_app/cubit/fhashcard_cubit/state.dart';
import 'package:flashcard_quiz_app/views/quiz_view.dart';
import 'package:flashcard_quiz_app/widgets/custom_material_button.dart';
import 'package:flashcard_quiz_app/widgets/flashcard_floating_action_button.dart';
import 'package:flashcard_quiz_app/widgets/flashcards_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPageView extends StatelessWidget {
  const CategoryPageView({super.key, required this.category});
final String category;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlashCardsCubit, FlashCardsState>(
      builder: (BuildContext context, FlashCardsState state) {
        int len=0;
        List<Map> flashcards = [];
        for(int i = 0; i < FlashCardsCubit.get(context).flashcards.length; i++){
          if(FlashCardsCubit.get(context).flashcards[i]['category'] == category){
            flashcards.add(FlashCardsCubit.get(context).flashcards[i]);
            len++;
          }
        }
        return Scaffold(
          key: FlashCardsCubit.get(context).scaffoldKey,
          appBar: AppBar(
            title: Text(
              category,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$len flashcards',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.yellow[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  len==0?const SizedBox(
                    height: 60,
                  ):const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: FlashCardsShape(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  len==0?const SizedBox(): CustomMaterialButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> QuizView(len: len, flashcards: flashcards,)));
                  },),
                ],
              ),
            ),
          ),
          floatingActionButton: FlashCardFloatingActionButton(category: category),
        );
      },
      listener: (BuildContext context, FlashCardsState state) {  },
    );
  }
}
