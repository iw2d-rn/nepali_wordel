import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:nepali_wordel/utils/calculate_chart_stats.dart';
import 'package:nepali_wordel/utils/calculate_stats.dart';
import 'package:nepali_wordel/constants/keybord_states.dart';
import 'package:nepali_wordel/data/keys_maps.dart';
import 'package:nepali_wordel/models/tile_model.dart';

class Controller extends ChangeNotifier {
  // String checkLine = 'false';
  String correctWord = "";
  int currentTile = 0;
  bool checkLine = false,
      isBackEnter = false,
      gameWon = false,
      gameCompleted = false,notEnoughLetters = false;
  int currentRow = 0;
  List<TileModel> tilesEntered = [];
  setCorrectWord({required String word}) => correctWord = word;
  setKeyTapped({required String value}) {
    if (value == "ENTER") {
      if (currentTile == 5 * (currentRow + 1)) {
        // currentRow++;
        isBackEnter = true;
        checkWord();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      notEnoughLetters=false;
      if (currentTile > 5 * (currentRow + 1) - 5) {
        currentTile--;
        isBackEnter = true;

        tilesEntered.removeLast();
      }
    } else {
      notEnoughLetters=false;

      if (currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(TileModel(
            letter: value, keyboardStates: KeyboardStates.notAnswered));
        currentTile++;
        isBackEnter = false;

      }
    }
    // print('current tile $currentTile and $currentRow');
    print('correct word at $currentTile and $currentRow');
    notifyListeners();
  }

  checkWord() {
    List<String> guessed = [];

    List<String> remainingCorrect = [];

    String guessedWord = "";

    for (var i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessed.add(tilesEntered[i].letter);
      print(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();

    for (var i = 0; i < correctWord.length; i++) {
      remainingCorrect.add(correctWord[i]);
    }

    if (guessedWord == correctWord) {
      for (var i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].keyboardStates = KeyboardStates.correct;
        keysMap.update(
            tilesEntered[i].letter, (value) => KeyboardStates.correct);
        gameWon = true;
        gameCompleted = true;
        // print(tilesEntered[i].letter);
      }
      print('word guessed correct $guessedWord == $correctWord');
    } else {
      for (var i = 0; i < 5; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].keyboardStates =
              KeyboardStates.correct;
          keysMap.update(guessedWord[i], (value) => KeyboardStates.correct);

          print('guessed word at $i ${guessedWord[i]}');
        }
      }
      for (var i = 0; i < remainingCorrect.length; i++) {
        for (var j = 0; j < 5; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * 5)].letter) {
            if (tilesEntered[j + (currentRow * 5)].keyboardStates !=
                KeyboardStates.correct) {
              tilesEntered[j + (currentRow * 5)].keyboardStates =
                  KeyboardStates.contains;
            }

            final resultKey = keysMap.entries.where((element) =>
                element.key == tilesEntered[j + (currentRow * 5)].letter);
            if (resultKey.single.value != KeyboardStates.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => KeyboardStates.contains);
            }
          }
        }
      }
      // for (var i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      //   if (tilesEntered[i].keyboardStates == KeyboardStates.notAnswered) {
      //     tilesEntered[i].keyboardStates = KeyboardStates.incorrect;
      //     keysMap.update(
      //         tilesEntered[i].letter, (value) => KeyboardStates.incorrect);
      //   }
      // }
      for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        if (tilesEntered[i].keyboardStates == KeyboardStates.notAnswered) {
          tilesEntered[i].keyboardStates = KeyboardStates.incorrect;

          final results = keysMap.entries
              .where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == KeyboardStates.notAnswered) {
            keysMap.update(
                tilesEntered[i].letter, (value) => KeyboardStates.incorrect);
          }
        }
      }
    }

    currentRow++;
    checkLine = true;
    if (currentRow == 8) {
      gameCompleted = true;
    }
    if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }
    notifyListeners();
  }
}
