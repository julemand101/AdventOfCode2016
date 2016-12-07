// --- Day 7: Internet Protocol Version 7 ---
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
    bool positive = false;
    StringBuffer buffer = new StringBuffer();

    for (int i = 0; i < line.length; i++) {
      String char = line[i];

      if (char == "[" || i + 1 >= line.length) {
        if (i + 1 >= line.length) {
          // Add the last char
          buffer.write(char);
        }
        // Buffer contains positive content
        if (positive == false && isABBA(buffer.toString())) {
          positive = true;
        }
        buffer.clear();
      } else if (char == "]") {
        // Buffer contains negative content
        if (isABBA(buffer.toString())) {
          positive = false;
          break;
        }
        buffer.clear();
      } else {
        // Still need more data!!!!
        buffer.write(char);
      }
    }

    if (positive) {
      count++;
    }
  });

  print("ABBA count: $count");
}

bool isABBA(String test) {
  for (int i = 0; i <= (test.length - 4); i++) {
    String sub = test.substring(i, i + 4);

    if (sub[0] == sub[3] &&
        sub[1] == sub[2] &&
        sub[0] != sub[1] &&
        sub[2] != sub[3]) {
      return true;
    }
  }

  return false;
}
