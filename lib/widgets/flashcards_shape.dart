import 'package:flutter/material.dart';

class FlashCardsShape extends StatelessWidget {
  const FlashCardsShape({super.key});
  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.4;
    double containerWidth = MediaQuery.of(context).size.width * 0.5;
    return Stack(
      children: [
        Transform.rotate(
          angle: -0.15,
          child: Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.lightBlueAccent,
            ),
          ),
        ),
        Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.redAccent,
          ),
        ),
        Transform.rotate(
          angle: 0.15,
          child: Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.yellow[300],
            ),
          ),
        ),
        Transform.rotate(
          angle: 0.25,
          child: Container(
            height: containerHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.green[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.007,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.007,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.007,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  const SizedBox(height: 40,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    height: MediaQuery.sizeOf(context).height * 0.007,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
