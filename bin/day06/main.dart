// --- Day 6: Signals and Noise ---
// http://adventofcode.com/2016/day/6

import 'dart:io';
import 'dart:convert';
import 'package:more/collection.dart';

main(List<String> args) async {
  File inputFile = new File("bin/day06/input.txt");
  List<Multiset> msg =
      new List.generate(8, (_) => new Multiset(), growable: false);

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    for (int i = 0; i < line.length; i++) {
      String letter = line[i];
      Multiset multiset = msg[i];

      multiset.add(letter);
    }
  });

  StringBuffer sb = new StringBuffer();
  for (Multiset s in msg) {
    sb.write(s.distinct
        .fold("", (prev, element) => (s[element] > s[prev]) ? element : prev));
  }

  print("Message: $sb");
}
