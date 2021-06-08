import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'color_control.dart';

class Locker extends ChangeNotifier {
  final _player = AudioCache();

  // make sure to load the assets through the loadAudioAsset function
  final String _soundA = 'Safe-Click-1.wav';
  final String _soundB = 'Safe-Click-4.wav';
  final String _correctSound = 'correct.wav';
  final String _wrongSound = 'wrong.wav';

  final int _maxSliderRange = 40;

  // _inputCodes (converted to doubles in _inputCodesDouble) are also the
  // initial values of the sliders
  List<int> _inputCodes = [26, 21, 15];

  // double values are for the sliders
  List<double> _inputCodesDouble = [];

  void setDoubles() {
    if (_inputCodesDouble.isEmpty) {
//      print("Decimal Values Initialized");
      _inputCodesDouble = _inputCodes.map((int e) => e.toDouble()).toList();
    }
  }

  void debugLog() {
    print("Input Codes int: $_inputCodes");
    print("Input Codes double: $_inputCodesDouble");
    print("Pass Code: $_passCode");
  }

  List<int> _passCode = [0, 0, 0];

  int get maxSliderRange => _maxSliderRange;

  int get a => _inputCodes[0];
  int get b => _inputCodes[1];
  int get c => _inputCodes[2];

  set a(int val) {
    _inputCodes[0] = val;
    notifyListeners();
  }

  set b(int val) {
    _inputCodes[1] = val;
    notifyListeners();
  }

  set c(int val) {
    _inputCodes[2] = val;
    notifyListeners();
  }

  double get aDouble => _inputCodesDouble[0];
  double get bDouble => _inputCodesDouble[1];
  double get cDouble => _inputCodesDouble[2];

  set aDouble(double val) {
    _inputCodesDouble[0] = val;
//    notifyListeners();
  }

  set bDouble(double val) {
    _inputCodesDouble[1] = val;
//    notifyListeners();
  }

  set cDouble(double val) {
    _inputCodesDouble[2] = val;
//    notifyListeners();
  }

  void playASound() => lowLatencyPlayer(0);
  void playBSound() => lowLatencyPlayer(1);
  void playCSound() => lowLatencyPlayer(2);

// play sound function can be changed into a single playSound funciton that takes in the slider number

  void loadAudioAssets() async {
    //await _player.loadAll([_soundA, _soundB, _correctSound, _wrongSound]);
    for (String audio in [_soundA, _soundB, _correctSound, _wrongSound]) {
      await _player.play(audio, volume: 0, mode: PlayerMode.LOW_LATENCY);
    }
  }

  void lowLatencyPlayer(int index) {
    if (_passCode[index] == _inputCodes[index]) {
      _player.play(_soundA, mode: PlayerMode.LOW_LATENCY);
    } else {
      _player.play(_soundB, mode: PlayerMode.LOW_LATENCY);
    }
  }

  void generatePassCode() {
    List<int> _newPassCode = [];
    for (int i = 0; i < _passCode.length; i++) {
      _newPassCode.add(Random().nextInt(maxSliderRange + 1));
    }
    _passCode = _newPassCode.cast();

    for (int x in _passCode) {
      assert(x <= _maxSliderRange,
          'max value of passcode is more than max value of the sliders');
    }
  }

  LockerState unlock() {
    int x = 0;
    for (int i = 0; i < _inputCodes.length; i++) {
      if (_inputCodes[i] == _passCode[i]) {
        x++;
      }
    }
    if (x == 3) {
      _player.play(_correctSound, mode: PlayerMode.LOW_LATENCY);
      return LockerState.unlocked;
    } else {
      _player.play(_wrongSound, mode: PlayerMode.LOW_LATENCY);
      return LockerState.locked;
    }
  }

  void selectColor() {
    // to prevent color scheme repetition
    while (newIndex == indexInUse) {
      newIndex = Random().nextInt(kColorList.length);
    }
    indexInUse = newIndex;
    List<Color> chosenColorSet = kColorList[indexInUse];
    kLight = chosenColorSet[0];
    kDark = chosenColorSet[1];
    kDarkLow = chosenColorSet[2];
  }
}

enum LockerState { unlocked, locked }

// what is _inputCodesDouble?
// The SleekCircularSlider outputs values as doubles but the locker processes the
// values as ints so a way to have both ints and doubles was necessary. So I implemented
// _inputCodesDouble. This list stores the double values of the sliders and is only
// used when a new page is pushed and the sliders need an initial value for initialization.
// the _inputCodes on the other hand stores ints and this list is used in the locking
// and unlocking mechanism.
