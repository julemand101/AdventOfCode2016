// --- Day 10: Balance Bots ---
// https://adventofcode.com/2016/day/10

import 'dart:io';
import 'dart:math';
import 'dart:convert';

Map<String, Thing> outputs = new Map();

class Thing {
  void take(int value) {}
}

class Output extends Thing {
  List<int> values = new List();

  void take(int value) {
    values.add(value);
  }

  String toString() {
    return "Values: $values";
  }
}

class Bot extends Thing {
  String name;
  String low;
  String high;
  int buffer = null;

  Bot(this.name, this.low, this.high);

  void take(int value) {
    if (buffer == null) {
      buffer = value;
    } else {
      checkForAnswerA(name, value, buffer);
      outputs[low].take(min(value, buffer));
      outputs[high].take(max(value, buffer));
    }
  }

  // --- Part One ---
  // Based on your instructions, what is the number of the bot that is
  // responsible for comparing value-61 microchips with value-17 microchips?
  void checkForAnswerA(String botId, int a, int b) {
    if (a == 61 && b == 17 || a == 17 && b == 61) {
      print("Answer A: $botId");
    }
  }
}

main(List<String> args) async {
  List<String> inputInstructions = new List();

  await new File("bin/day10/input.txt")
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    if (line.startsWith("value ")) {
      // value 5 goes to bot 2
      inputInstructions.add(line);
    } else {
      // bot 2 gives low to bot 1 and high to bot 0
      // bot 1 gives low to output 1 and high to bot 0
      int givesIndex = line.indexOf(" gives ");
      int andIndex = line.indexOf(" and ");

      String botId = line.substring(0, givesIndex);
      String lowId = line.substring(givesIndex + 14, andIndex);
      String highId = line.substring(andIndex + 13);

      if (lowId.startsWith("output") && !outputs.containsKey(lowId)) {
        outputs[lowId] = new Output();
      }

      if (highId.startsWith("output") && !outputs.containsKey(highId)) {
        outputs[highId] = new Output();
      }

      outputs[botId] = new Bot(botId, lowId, highId);
    }
  });

  for (String input in inputInstructions) {
    int value = int.parse(input.substring(6, input.indexOf(" goes")));
    String botId = input.substring(input.indexOf("bot")).trim();

    outputs[botId].take(value);
  }

  // --- Part Two ---
  // What do you get if you multiply together the values of one chip in each
  // of outputs 0, 1, and 2?
  int answerB = (outputs["output 0"] as Output).values[0] *
      (outputs["output 1"] as Output).values[0] *
      (outputs["output 2"] as Output).values[0];

  print("Answer B: $answerB");
}
