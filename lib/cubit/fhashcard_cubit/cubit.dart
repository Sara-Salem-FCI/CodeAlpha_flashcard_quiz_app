import 'package:flashcard_quiz_app/cubit/fhashcard_cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class FlashCardsCubit extends Cubit<FlashCardsState> {
  FlashCardsCubit() : super(InitialFlashCardsState());


  static FlashCardsCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> flashcards = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> createDatabase() async {
    database = await openDatabase('flashcards.db', version: 3,
        onCreate: (Database db, int version) async {
      await db
          .execute(
              'CREATE TABLE flashcards (id INTEGER PRIMARY KEY, question TEXT, true_answer TEXT, false_answer TEXT, category TEXT)')
          .then((value) => //print('table created')
              null)
          .catchError((e) {
        throw e;
      });
    }, onOpen: (database) async {
      print('database opened');
      await getDataFromDatabase(database).then((value) {
        flashcards = value;
        emit(GetFlashCardsState());
      });
    }).then((value) {
      database = value;
      emit(InitialFlashCardsState());
      return value;
    });
  }

  Future<void> insertIntoDatabase(
      {required String question,
      required String trueAnswer,
      required String falseAnswer,
      required String category}) async {
    return await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO flashcards(question, true_answer, false_answer, category) VALUES("$question", "$trueAnswer", "$falseAnswer", "$category")')
          .then((value) => value)
          .then((value) {
        emit(AddFlashCardState());
      }).catchError((e) {
        throw e;
      });
      //print('inserted1: $id1');
    });
  }

  Future<List<Map<String, dynamic>>> getDataFromDatabase(Database database) async {
    final results = await database.rawQuery('SELECT * FROM flashcards');
    emit(GetFlashCardsState()); // Make sure this is valid for your state management
    print(results);
    return results;
  }


  bool isBottomSheetOpened = false;
  TextEditingController questionController = TextEditingController();
  TextEditingController trueAnswerController = TextEditingController();
  TextEditingController falseAnswerController = TextEditingController();

  closeButtonSheet() {
    isBottomSheetOpened = false;
    questionController.clear();
    trueAnswerController.clear();
    falseAnswerController.clear();
    emit(CloseFlashCardBottomSheetState());
  }

  closeButtonSheetManual() {
    isBottomSheetOpened = false;
    emit(CloseFlashCardBottomSheetManualState());
  }

  openButtonSheet() {
    isBottomSheetOpened = true;
    emit(OpenFlashCardBottomSheetState());
  }
}
