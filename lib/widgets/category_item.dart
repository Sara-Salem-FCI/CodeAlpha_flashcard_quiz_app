import 'package:flashcard_quiz_app/cubit/categories_cubit/cubit.dart';
import 'package:flashcard_quiz_app/views/category_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/categories_cubit/states.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.color, required this.index});
final Color color;
final int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      builder: (BuildContext context, state) {
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryPageView(category: CategoriesCubit.get(context).categories[index]['category'],)));
          },
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: color,
                  ),
                  height: MediaQuery.sizeOf(context).height*0.14,
                  width: MediaQuery.sizeOf(context).width*0.42,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                       CategoriesCubit.get(context).categories[index]['category'],
                       style: const TextStyle(
                         color: Colors.black,
                         fontSize: 22,
                         fontWeight: FontWeight.bold,
                       ),
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {  },
    );
  }
}
