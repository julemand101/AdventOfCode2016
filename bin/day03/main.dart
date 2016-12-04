// --- Day 3: Squares With Three Sides ---
// http://adventofcode.com/2016/day/3

import 'dart:io';
import 'dart:convert';

main(List<String> args) async {
  File inputFile = new File("bin/day03/input.txt");
  int count = 0;

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    List<String> list = line.split(" ");
    list.removeWhere((String element) => element.length == 0);

    if (check(int.parse(list[0]), int.parse(list[1]), int.parse(list[2]))) {
      count++;
    }
  });

  print("Answer: $count");
}

bool check(int a, int b, int c) {
  return a + b > c && a + c > b && b + c > a;
}
