// --- Day 8: Two-Factor Authentication ---
// http://adventofcode.com/2016/day/8

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
