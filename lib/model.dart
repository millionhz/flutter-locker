import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';

class Locker extends ChangeNotifier {
  final _player = AudioCache();
  final String _soundA = 'Safe-Click-1.wav';
  final String _soundB = 'Safe-Click-4.wav';
  final int _maxSliderRange = 30;

  // _inputCodes is also the initial values of the sliders
  List<int> _inputCodes = [22, 20, 18];
  List<int> _passCode = [0, 0, 0];

  int get maxSliderRange => _maxSliderRange;

  int get a => _inputCodes[0];
  int get b => _inputCodes[1];
  int get c => _inputCodes[2];

//  String get aSound => (_passCode[0] == _inputCodes[0]) ? _soundA : _soundB;
//  String get bSound => (_passCode[1] == _inputCodes[1]) ? _soundA : _soundB;
//  String get cSound => (_passCode[2] == _inputCodes[2]) ? _soundA : _soundB;

  void playASound() => lowLatencyPlayer(0);
  void playBSound() => lowLatencyPlayer(1);
  void playCSound() => lowLatencyPlayer(2);

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
//    print(_passCode);
  }

  LockerState unlock() {
    int x = 0;
    for (int i = 0; i < _inputCodes.length; i++) {
      if (_inputCodes[i] == _passCode[i]) {
        x++;
      }
    }
    if (x == 3) {
      _player.play('correct.wav');
      generatePassCode();
      return LockerState.unlocked;
    } else {
      _player.play('wrong.wav');
      return LockerState.locked;
    }
  }
}

enum LockerState { unlocked, locked }
