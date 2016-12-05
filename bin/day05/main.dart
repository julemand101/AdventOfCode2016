// --- Day 5: How About a Nice Game of Chess? ---
// http://adventofcode.com/2016/day/5

import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

const String input = "wtnhxymk";

main(List<String> args) {
  print("Password A: ${getPasswordA(input)}");
  print("Password B: ${getPasswordB(input)}");
}

String getPasswordA(String input) {
  StringBuffer sb = new StringBuffer();

  for (int count = 0; sb.length < 8; count++) {
    List<int> encoded = ASCII.encode("$input$count");
    String sum = crypto.md5.convert(encoded).toString();

    if (sum.startsWith("00000")) {
      sb.write(sum[5]);
    }
  }

  return sb.toString();
}

String getPasswordB(String input) {
  List<String> list = new List.filled(8, "_");

  for (int count = 0; list.contains("_"); count++) {
    List<int> encoded = ASCII.encode("$input$count");
    String sum = crypto.md5.convert(encoded).toString();

    if (sum.startsWith("00000")) {
      int pos = int.parse(sum[5], onError: (_) => -1);

      if (pos != -1 && pos < list.length && list[pos] == "_") {
        list[pos] = sum[6];
        print(list);
      }
    }
  }

  StringBuffer sb = new StringBuffer();
  list.forEach((String s) => sb.write(s));
  return sb.toString();
}
