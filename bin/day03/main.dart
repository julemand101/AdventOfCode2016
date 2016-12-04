// --- Day 3: Squares With Three Sides ---
// http://adventofcode.com/2016/day/3

import 'dart:io';
import 'dart:convert';

main(List<String> args) async {
  await task_a();
  await task_b();
}

task_a() async {
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

  print("Answer A: $count");
}

task_b() async {
  File inputFile = new File("bin/day03/input.txt");
  List<List> buffer = new List();
  int count = 0;

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    List<String> list = line.split(" ");
    list.removeWhere((String element) => element.length == 0);

    buffer.add(list);

    if (buffer.length == 3) {
      for (int i = 0; i < buffer.length; i++) {
        if (check(int.parse(buffer[0][i]), int.parse(buffer[1][i]),
            int.parse(buffer[2][i]))) {
          count++;
        }
      }
      buffer.clear();
    }
  });

  print("Answer B: $count");
}

bool check(int a, int b, int c) {
  return a + b > c && a + c > b && b + c > a;
}
