// --- Day 23: Safe Cracking ---
// http://adventofcode.com/2016/day/23

List<List<String>> input = [
  "cpy a b",
  "dec b",
  "cpy a d",
  "cpy 0 a",
  "cpy b c",
  "inc a",
  "dec c",
  "jnz c -2",
  "dec d",
  "jnz d -5",
  "dec b",
  "cpy b c",
  "cpy c d",
  "dec d",
  "inc c",
  "jnz d -2",
  "tgl c",
  "cpy -16 c",
  "jnz 1 c",
  "cpy 76 c",
  "jnz 80 d",
  "inc a",
  "inc d",
  "jnz d -2",
  "inc c",
  "jnz c -5",
].map((String line) => line.split(" ")).toList(growable: false);

main(List<String> args) {
  Map<String, int> register = new Map();
  register["a"] = 7; // the number of eggs
  register["b"] = 0;
  register["c"] = 0;
  register["d"] = 0;
  print("Answer A: ${runProgram(input, register)}");
}

int runProgram(List<List<String>> program, Map<String, int> register) {
  int pos = 0;

  while (pos < program.length) {
    List<String> command = program[pos];

    if (command[0] == "cpy") {
      int value = getValue(command[1], register);
      String reg = command[2];

      if (register.containsKey(reg)) {
        register[reg] = value;
      }
    } else if (command[0] == "inc") {
      String reg = command[1];

      if (register.containsKey(reg)) {
        register[reg]++;
      }
    } else if (command[0] == "dec") {
      String reg = command[1];

      if (register.containsKey(reg)) {
        register[reg]--;
      }
    } else if (command[0] == "jnz") {
      int value = getValue(command[1], register);

      if (value != 0) {
        pos += getValue(command[2], register);
        continue;
      }
    } else if (command[0] == "tgl") {
      int value = pos + getValue(command[1], register);

      if (value > 0 && value < program.length) {
        String c = program[value][0];

        if (program[value].length == 2) {
          // one-argument instructions
          if (c == "inc") {
            program[value][0] = "dec";
          } else {
            program[value][0] = "inc";
          }
        } else if (program[value].length == 3) {
          // two-argument instructions
          if (c == "jnz") {
            program[value][0] = "cpy";
          } else {
            program[value][0] = "jnz";
          }
        } else {
          throw command;
        }
      }
    } else {
      throw command;
    }

    pos++;
  }

  return register["a"];
}

int getValue(String input, Map<String, int> register) {
  return int.parse(input, onError: (String source) => register[source]);
}
