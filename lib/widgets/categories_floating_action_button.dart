import 'package:flashcard_quiz_app/cubit/categories_cubit/cubit.dart';
import 'package:flashcard_quiz_app/cubit/categories_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesFloatingActionButton extends StatelessWidget {
  const CategoriesFloatingActionButton({super.key});
  static var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      builder: (BuildContext context, CategoriesState state) {
        return FloatingActionButton(
          backgroundColor: Colors.green[300],
            onPressed: () {
              CategoriesCubit.get(context).getDataFromDatabase(CategoriesCubit.get(context).database).then((value) {
                  CategoriesCubit.get(context).categories = value;
                });
               if (CategoriesCubit.get(context).isBottomSheetOpened) {
                if (formKey.currentState!.validate()) {
                  CategoriesCubit.get(context).insertIntoDatabase(category: CategoriesCubit.get(context).categoryController.text).then((value) {
                    BlocProvider.of<CategoriesCubit>(context).getDataFromDatabase(BlocProvider.of<CategoriesCubit>(context).database).then((value) {
                      BlocProvider.of<CategoriesCubit>(context).categories = value;}).then((value) {
                        CategoriesCubit.get(context).closeButtonSheet();
                    });
                  });
                }
              } else {
                CategoriesCubit.get(context).scaffoldKey.currentState
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
                                  labelText: 'Enter Category',
                                ),
                                keyboardType: TextInputType.text,
                                controller: CategoriesCubit.get(context).categoryController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Category must not be empty';
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
                    CategoriesCubit.get(context).getDataFromDatabase(CategoriesCubit.get(context).database).then((value) {
                      CategoriesCubit.get(context).categories = value;
                      CategoriesCubit.get(context).closeButtonSheetManual();
                  });
                });
                CategoriesCubit.get(context).openButtonSheet();
              }
            },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.black,
            size: 40,
          ),
        );
      },
      listener: (BuildContext context, CategoriesState state) {
            if(state is CloseBottomSheetState){
              Navigator.pop(context);
        }
      },
    );
  }
}
