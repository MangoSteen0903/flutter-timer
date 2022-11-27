import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const defaultSeconds = 1500;

  int timerCounts = defaultSeconds;
  bool isRunning = false;
  int pomodoro = 0;
  late Timer timer;

  void onTick(Timer timer) {
    setState(
      () {
        if (timerCounts == 0) {
          pomodoro = pomodoro + 1;
          onReset();
        } else {
          timerCounts = timerCounts - 1;
        }
      },
    );
  }

  void changeState() {
    setState(() {
      isRunning = !isRunning;
    });
  }

  void onPlay() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    changeState();
  }

  void onPause() {
    timer.cancel();
    changeState();
  }

  void onReset() {
    setState(() {
      timerCounts = defaultSeconds;
      timer.cancel();
      isRunning = false;
    });
  }

  String format(int seconds) {
    var formattedString =
        Duration(seconds: seconds).toString().split(".")[0].substring(2, 7);
    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(timerCounts),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontSize: 100,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: isRunning ? onPause : onPlay,
                    icon: isRunning
                        ? const Icon(Icons.pause_circle_outline)
                        : const Icon(Icons.play_circle_outline),
                    iconSize: 150,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: onReset,
                    child: Container(
                      alignment: Alignment.center,
                      width: 170,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoro",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).backgroundColor,
                          ),
                        ),
                        Text(
                          "$pomodoro",
                          style: TextStyle(
                            fontSize: 42,
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
