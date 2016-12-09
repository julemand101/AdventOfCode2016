// --- Day 9b: Explosives in Cyberspace ---
// https://adventofcode.com/2016/day/9

import 'dart:io';
import 'dart:convert';

main(List<String> args) async {
  String input = await new File("bin/day09/input.txt")
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .first;

  StringBuffer output = new StringBuffer();
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

      print("$chars : $repeat");

      String s = input.substring(i+1,i+chars+1);
      for (int k = 0; k < repeat; k++) {
        output.write(s);
      }
      i += chars;
    } else if (char == "(" || markerRead) {
      buffer.write(char);
      markerRead = true;
    } else {
      output.write(char);
    }
  }
  print(output);
  print("Decompressed length: ${output.length}");
}
