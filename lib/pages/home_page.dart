import 'package:coin_cap/providers/game_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  late final double? deviceHeight, deviceWidth;
  final String difficultyA;
  HomePageProvider? pageProvider;

  HomePage({super.key , required this.difficultyA});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider(context: context , difficultyA: difficultyA),
      child: buildUi(),
    );
  }

  Widget buildUi() {
    return Builder(builder: (context) {
      pageProvider = context.watch<HomePageProvider>();
      if (pageProvider?.questions != null) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: deviceHeight! * 0.05),
            child: gameUi(),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    });
  }

  Widget gameUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        questionText(),
        Column(
          children: [
            trueButton(),
            SizedBox(
              height: deviceHeight! * 0.01,
            ),
            falseButton(),
          ],
        ),
      ],
    );
  }

  Widget questionText() {
    return Text(
      pageProvider!.getCurrentQuestionText(),
      style:const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider?.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider?.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child:const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
