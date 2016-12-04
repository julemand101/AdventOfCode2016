// --- Day 4: Security Through Obscurity ---
// http://adventofcode.com/2016/day/4

import 'dart:io';
import 'dart:convert';

class Letter {
  String letter;
  int count;

  Letter(this.letter, this.count);

  String toString() {
    return "$letter ($count)";
  }
}

main(List<String> args) async {
  File inputFile = new File("bin/day04/input.txt");
  int sum = 0;

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    int id = getId(line);
    String hash = getHash(line);
    String name = getName(line);

    Map<String, int> map = new Map();

    for (int i = 0; i < name.length; i++) {
      String value = name[i];

      if (map.containsKey(value)) {
        map[value]++;
      } else {
        map[value] = 1;
      }
    }

    List<Letter> list = new List();

    map.forEach((String key, int value) {
      list.add(new Letter(key, value));
    });

    list.sort((Letter a, Letter b) {
      if (a.count == b.count) {
        return a.letter.compareTo(b.letter);
      } else {
        return b.count - a.count;
      }
    });

    StringBuffer sb = new StringBuffer();
    for (Letter l in list.getRange(0, 5)) {
      sb.write(l.letter);
    }

    if (sb.toString() == hash) {
      sum += id;

      if (getDecryptedName(line, id).contains("northpole object storage")) {
        print("Answer B:");
        print("$line - decypt: ${getDecryptedName(line, id)} - id: $id");
        print("");
      }
    }
  });

  print("Answer A: $sum");
}

int getId(String line) {
  return int.parse(line.split("-").last.split("[").first);
}

String getHash(String line) {
  String s = line.split("[").last;
  return s.substring(0, s.length - 1);
}

String getName(String line) {
  StringBuffer result = new StringBuffer();
  List<String> nameParts = line.split("-");
  nameParts.removeLast();

  for (String part in nameParts) {
    result.write(part);
  }

  return result.toString();
}

List<String> alphabet = [
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z"
];

String getDecryptedName(String line, int id) {
  List<String> nameParts = line.split("-");
  nameParts.removeLast();

  StringBuffer sb = new StringBuffer();

  String encryptedString = nameParts.join(" ");

  for (int i = 0; i < encryptedString.length; i++) {
    String value = encryptedString[i];

    if (value == " ") {
      sb.write(" ");
      continue;
    }

    int pos = alphabet.indexOf(value);
    int newPos = (pos + id) % alphabet.length;

    sb.write(alphabet[newPos]);
  }

  return sb.toString();
}
