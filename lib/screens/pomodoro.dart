import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_w10_3th_d11_pomodoro/components/card.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final _listOfTotalSeconds = [900, 1200, 1500, 1800, 2100];
  final int _seletedIndex = 2;
  late var _totalSeconds = _listOfTotalSeconds[_seletedIndex];
  final _restingSeconds = 300;
  final _totalRounds = 4;
  final _totalGoals = 2;

  late var _currentSeconds = _totalSeconds;
  var _currentRounds = 0;
  var _currentGoals = 0;

  bool _isRunning = false;
  bool _isResting = false;
  late Timer _timer;

  void _setTotalSeconds(int seconds) {
    _totalSeconds = seconds;
    _onResetPressed();
  }

  void _onTick(Timer timer) {
    if (_currentSeconds == 0) {
      if (!_isResting) {
        _isResting = true;
        if (_currentRounds < _totalRounds - 1) {
          setState(() {
            _currentRounds = _currentRounds + 1;
            _currentSeconds = _restingSeconds;
          });
        } else if (_currentGoals < _totalGoals - 1) {
          setState(() {
            _currentGoals = _currentGoals + 1;
            _currentRounds = 0;
            _currentSeconds = _restingSeconds;
          });
        } else {
          _onResetPressed();
        }
      } else {
        setState(() {
          _isResting = false;
          _currentSeconds = _totalSeconds;
        });
      }
    } else {
      setState(() {
        _currentSeconds = _currentSeconds - 1;
      });
    }
  }

  void _onStartPressed() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 1),
      _onTick,
    );
    setState(() {
      _isRunning = true;
    });
  }

  void _onPausePressed() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _onResetPressed() {
    setState(() {
      _currentSeconds = _totalSeconds;
      _currentRounds = 0;
      _currentGoals = 0;
      _isResting = false;
      _onPausePressed();
    });
  }

  String _formatMinutes(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4);
  }

  String _formatSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    final timerCardWidth = MediaQuery.of(context).size.width * 0.35;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              const Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "POMOTIMER",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimerCard(
                      content: _formatMinutes(_currentSeconds),
                      width: timerCardWidth,
                      isDimmed: _isResting,
                    ),
                    Container(
                        width: 26,
                        alignment: Alignment.center,
                        child: Text(
                          ":",
                          style: TextStyle(
                            fontSize: 55,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        )),
                    TimerCard(
                      content: _formatSeconds(_currentSeconds),
                      width: timerCardWidth,
                      isDimmed: _isResting,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ..._listOfTotalSeconds.map(
                        (item) => GestureDetector(
                          onTap: () => _setTotalSeconds(item),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              width: 75,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: item == _totalSeconds
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withOpacity(0.5),
                                  width: 2.5,
                                ),
                                color: item == _totalSeconds
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : null,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "${item ~/ 60}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: item == _totalSeconds
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: _isRunning ? _onPausePressed : _onStartPressed,
                      child: Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
                          // color: Colors.yellow,
                        ),
                        child: _isRunning
                            ? const Icon(
                                Icons.pause,
                                size: 50,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 50,
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _onResetPressed,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
                          // color: Colors.yellow,
                        ),
                        child: const Icon(
                          Icons.settings_backup_restore_rounded,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$_currentRounds/$_totalRounds",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        ),
                        const Text(
                          "ROUND",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$_currentGoals/$_totalGoals",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.5),
                          ),
                        ),
                        const Text(
                          "GOAL",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
