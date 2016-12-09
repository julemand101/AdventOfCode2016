// --- Day 9a: Explosives in Cyberspace ---
// https://adventofcode.com/2016/day/9

import 'dart:io';
import 'dart:convert';

main(List<String> args) async {
  String input = await new File("bin/day09/input.txt")
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .first;

  int count = 0;
  StringBuffer buffer = new StringBuffer();
  bool markerRead = false;

  for (int i = 0; i < input.length; i++) {
    String char = input[i];

    if (char == ")") {
      buffer.write(char);
      markerRead = false;

      String marker = buffer.toString();
      buffer.clear();

      List<String> ls = marker.substring(1, marker.length - 1).split("x");
      int chars = int.parse(ls[0]);
      int repeat = int.parse(ls[1]);

      count += chars * repeat;
      i += chars;
    } else if (char == "(" || markerRead) {
      buffer.write(char);
      markerRead = true;
    } else {
      count++;
    }
  }

  print("Decompressed length: ${count}");
}
