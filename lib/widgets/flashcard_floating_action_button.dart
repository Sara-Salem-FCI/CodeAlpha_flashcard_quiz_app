import 'package:flashcard_quiz_app/cubit/fhashcard_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/fhashcard_cubit/state.dart';

class FlashCardFloatingActionButton extends StatelessWidget {
  const FlashCardFloatingActionButton({super.key, required this.category});

  final String category;
  static var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlashCardsCubit, FlashCardsState>(
      builder: (BuildContext context, FlashCardsState state) {
        return FloatingActionButton(
          backgroundColor: Colors.green[300],
          onPressed: () {
            print(category);
            FlashCardsCubit.get(context)
                .getDataFromDatabase(FlashCardsCubit.get(context).database)
                .then((value) {
              FlashCardsCubit.get(context).flashcards = value;
            });
            if (FlashCardsCubit.get(context).isBottomSheetOpened) {
              if (formKey.currentState!.validate()) {
                FlashCardsCubit.get(context)
                    .insertIntoDatabase(
                        question: FlashCardsCubit.get(context)
                            .questionController
                            .text,
                        trueAnswer: FlashCardsCubit.get(context)
                            .trueAnswerController
                            .text,
                        falseAnswer: FlashCardsCubit.get(context)
                            .falseAnswerController
                            .text,
                        category: category)
                    .then((value) {
                  BlocProvider.of<FlashCardsCubit>(context)
                      .getDataFromDatabase(
                          BlocProvider.of<FlashCardsCubit>(context).database)
                      .then((value) {
                    BlocProvider.of<FlashCardsCubit>(context).flashcards =
                        value;
                  }).then((value) {
                    FlashCardsCubit.get(context).closeButtonSheet();
                  });
                });
              }
            } else {
              FlashCardsCubit.get(context)
                  .scaffoldKey
                  .currentState
                  ?.showBottomSheet(
                    (context) => IntrinsicHeight(
                      child: Container(
                        color: Colors.black12,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Enter Question',
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: FlashCardsCubit.get(context)
                                      .questionController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Question must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Enter True Answer',
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: FlashCardsCubit.get(context)
                                      .trueAnswerController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'True Answer must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText: 'Enter False Answer',
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: FlashCardsCubit.get(context)
                                      .falseAnswerController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'False Answer must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .closed
                  .then((value) {
                FlashCardsCubit.get(context)
                    .getDataFromDatabase(FlashCardsCubit.get(context).database)
                    .then((value) {
                  FlashCardsCubit.get(context).flashcards = value;
                  FlashCardsCubit.get(context).closeButtonSheetManual();
                });
              });
              FlashCardsCubit.get(context).openButtonSheet();
            }
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.black,
            size: 40,
          ),
        );
      },
      listener: (BuildContext context, FlashCardsState state) {
        if (state is CloseFlashCardBottomSheetState) {
          Navigator.pop(context);
        }
      },
    );
  }
}
