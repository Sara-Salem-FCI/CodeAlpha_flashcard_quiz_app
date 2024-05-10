import 'package:flashcard_quiz_app/cubit/categories_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(InitialCategoriesState());
  static CategoriesCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> categories = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> createDatabase() async {
    database = await openDatabase(
        'quiz.db', version: 3,
        onCreate: (Database db, int version) async {
          await db
              .execute(
              'CREATE TABLE categories (id INTEGER PRIMARY KEY, category TEXT)')
              .then((value) => //print('table created')
          null )
              .catchError((e) {
            throw e;
          });
        },
        onOpen: (database) async {
          //print('database opened');
          await getDataFromDatabase(database).then((value) {
              categories = value;
              emit(GetCategoriesState());
          });
        }).then((value) {
          database = value;
          emit(InitialCategoriesState());
          return value;
    });
  }

  Future<void> insertIntoDatabase({required String category}) async {
    return await database.transaction((txn) async {
      await txn
          .rawInsert(
          'INSERT INTO categories(category) VALUES("$category")')
          .then((value) => value).then((value) {
            emit(AddCategoriesState());
      })
          .catchError((e) {
        throw e;
      });
      //print('inserted1: $id1');
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM categories').then((value) {
      emit(GetCategoriesState());
      return value;
    });
  }

  Future<List<Map<String, Object?>>> deleteDatabase(id) async {
    return await database.rawQuery('DELETE FROM notes WHERE id = $id').then((value) {
      emit(DeleteCategoriesState());
      return value;
    });
  }

  bool isBottomSheetOpened = false;
  TextEditingController categoryController = TextEditingController();

  closeButtonSheet(){
    isBottomSheetOpened = false;
    categoryController.clear();
    emit(CloseBottomSheetState());
  }
  closeButtonSheetManual(){
    isBottomSheetOpened = false;
    emit(CloseBottomSheetManualState());
  }

  openButtonSheet(){
    isBottomSheetOpened = true;
    emit(OpenBottomSheetState());
  }
}