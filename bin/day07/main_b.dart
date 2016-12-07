// --- Day 7b: Internet Protocol Version 7 ---
// http://adventofcode.com/2016/day/7

import 'dart:io';
import 'dart:convert';

main(List<String> args) async {
  File inputFile = new File("bin/day07/input.txt");

  int count = 0;

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    Set<String> positiveSet = new Set();
    Set<String> negativeSet = new Set();
    StringBuffer buffer = new StringBuffer();

    for (int i = 0; i < line.length; i++) {
      String char = line[i];

      if (char == "[" || i + 1 >= line.length) {
        if (i + 1 >= line.length) {
          // Add the last char
          buffer.write(char);
        }
        // Buffer contains positive content
        positiveSet.addAll(getABA(buffer.toString()));
        buffer.clear();
      } else if (char == "]") {
        // Buffer contains negative content
        negativeSet.addAll(getBAB(buffer.toString()));
        buffer.clear();
      } else {
        // Still need more data!!!!
        buffer.write(char);
      }
    }

    if (positiveSet.intersection(negativeSet).length > 0) {
      count++;
    }
  });

  print("ABA count: $count");
}

Iterable<String> getABA(String test) sync* {
  for (int i = 0; i <= (test.length - 3); i++) {
    String sub = test.substring(i, i + 3);

    if (sub[0] == sub[2] &&
        sub[0] != sub[1]) {
      yield sub;
    }
  }
}

Iterable<String> getBAB(String test) {
  return getABA(test).map(toBAB);
}

String toBAB(String aba) {
  return "${aba[1]}${aba[0]}${aba[1]}";
}
