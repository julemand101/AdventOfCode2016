// --- Day 8: Two-Factor Authentication ---
// http://adventofcode.com/2016/day/8

import 'dart:io';
import 'dart:convert';

const int SCREEN_WIDE = 50;
const int SCREEN_TALL = 6;

main(List<String> args) async {
  File inputFile = new File("bin/day08/input.txt");

  List<List<bool>> display = new List.generate(
      SCREEN_TALL, (_) => new List.filled(SCREEN_WIDE, false));

  await inputFile
      .openRead()
      .transform(new AsciiDecoder())
      .transform(new LineSplitter())
      .forEach((String line) {
    print(line);

    if (line.startsWith("rect ")) {
      List<String> temp = line.substring(5).split("x");
      int wide = int.parse(temp[0]); // x
      int tall = int.parse(temp[1]); // y

      drawRect(display, wide, tall);
    } else if (line.startsWith("rotate row y=")) {
      List<String> temp = line.substring(13).split(" by ");
      int y = int.parse(temp[0]);
      int count = int.parse(temp[1]);

      rotateRow(display, y, count);
    } else if (line.startsWith("rotate column x=")) {
      List<String> temp = line.substring(16).split(" by ");
      int x = int.parse(temp[0]);
      int count = int.parse(temp[1]);

      rotateColumn(display, x, count);
    }

    print(displayToString(display));
    print("");
  });

  print("Number of active pixels: ${countPixels(display)}");
}

void drawRect(List<List<bool>> display, int wide, int tall) {
  for (int x = 0; x < tall; x++) {
    for (int y = 0; y < wide; y++) {
      display[x][y] = true;
    }
  }
}

void rotateColumn(List<List<bool>> display, int x, int count) {
  for (int i = 0; i < count; i++) {
    bool prev = display[SCREEN_TALL - 1][x];

    for (int y = 0; y < SCREEN_TALL; y++) {
      bool temp = display[y][x];
      display[y][x] = prev;
      prev = temp;
    }
  }
}

void rotateRow(List<List<bool>> display, int y, int count) {
  for (int i = 0; i < count; i++) {
    bool prev = display[y][SCREEN_WIDE - 1];

    for (int x = 0; x < SCREEN_WIDE; x++) {
      bool temp = display[y][x];
      display[y][x] = prev;
      prev = temp;
    }
  }
}

String displayToString(List<List<bool>> display) {
  StringBuffer sb = new StringBuffer();

  for (List<bool> d in display) {
    for (bool b in d) {
      if (b) {
        sb.write("#");
      } else {
        sb.write(" ");
      }
    }
    sb.writeln();
  }

  return sb.toString();
}

int countPixels(List<List<bool>> display) {
  // Turned on pixel is 'true' so it is easy to count
  return display.expand((line) => line).where((pixel) => pixel).length;
}
