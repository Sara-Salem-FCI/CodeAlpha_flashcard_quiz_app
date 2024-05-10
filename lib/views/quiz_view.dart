import 'package:flashcard_quiz_app/cubit/fhashcard_cubit/cubit.dart';
import 'package:flashcard_quiz_app/views/result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/fhashcard_cubit/state.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key, required this.len, required this.flashcards, });
  final List<Map> flashcards;
  final int len;
  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
   int index=0;
   int counter=0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlashCardsCubit, FlashCardsState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.flashcards[index]['id']} / ${widget.len}'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width*0.78,
                      height: MediaQuery.sizeOf(context).height*0.55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.yellow[300]!,
                          width: 5,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                                widget.flashcards[index]['question'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              width: MediaQuery.sizeOf(context).width*0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.yellow[300]!,
                                    width: 5,
                                  )
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  counter++;
                                  if(index==widget.flashcards.length-1){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultView(result: counter, total:widget.flashcards.length)));
                                  }else{
                                    setState(() {
                                      index++;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.flashcards[index]['true_answer'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              width: MediaQuery.sizeOf(context).width*0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.yellow[300]!,
                                    width: 5,
                                  )
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  if(index==widget.flashcards.length-1){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultView(result: counter, total: widget.flashcards.length)));
                                  }else{
                                    setState(() {
                                      index++;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.flashcards[index]['false_answer'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
