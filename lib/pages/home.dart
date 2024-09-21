import 'package:coin_cap/pages/home_page.dart';
import 'package:flutter/material.dart';

class HomeA extends StatefulWidget {
  const HomeA({super.key});

  @override
  State<HomeA> createState() => _HomeAState();
}

class _HomeAState extends State<HomeA> {
  double? deviceHeight, deviceWidth;
  double currentDifficulty = 0;
  final List<String> difficulityLevels = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.10),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appTitle(),
            difficulitySlider(),
            startGameButton(),
          ],
        )),
      ),
    );
  }

  Widget appTitle() {
    return Column(
      children: [
        const Text(
          'Frivia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          difficulityLevels[currentDifficulty.toInt()],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  Widget difficulitySlider() {
    return Slider(
      label: 'Difficulty',
      min: 0,
      max: 2,
      divisions: 2,
      value: currentDifficulty,
      onChanged: (value) {
        setState(
          () {
            currentDifficulty = value;
          },
        );
      },
    );
  }

  Widget startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return HomePage(difficultyA:difficulityLevels[currentDifficulty.toInt()].toLowerCase() ,);
            },
          ),
        );
      },
      color: Colors.blue,
      minWidth: deviceWidth! * 0.80,
      height: deviceHeight! * 0.10,
      child: const Text(
        'Start',
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
