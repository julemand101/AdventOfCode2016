// --- Day 10: Balance Bots ---
// https://adventofcode.com/2016/day/10

import 'dart:io';
import 'dart:convert';

main(List<String> args) async {
  File inputFile = new File("bin/day10/input.txt");

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    print(line);
  });
}
