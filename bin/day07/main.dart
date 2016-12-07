// --- Day 7: Internet Protocol Version 7 ---
// http://adventofcode.com/2016/day/7

import 'dart:io';
import 'dart:convert';

main(List<String> args) async {
  File inputFile = new File("bin/day07/input.txt");

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {

      });
}
