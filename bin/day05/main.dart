// --- Day 5: How About a Nice Game of Chess? ---
// http://adventofcode.com/2016/day/5

import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

const String input = "wtnhxymk";

main(List<String> args) {
  StringBuffer sb = new StringBuffer();

  for (int count = 0; sb.length < 8; count++) {
    List<int> encoded = ASCII.encode("$input$count");
    String sum = crypto.md5.convert(encoded).toString();

    if (sum.startsWith("00000")) {
      sb.write(sum[5]);
      print("$sum => $count");
    }
  }

  print("Password: $sb");
}
