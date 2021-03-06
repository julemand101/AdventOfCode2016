// --- Day 12: Leonardo's Monorail ---
// http://adventofcode.com/2016/day/12

List<String> input = [
  "cpy 1 a",
  "cpy 1 b",
  "cpy 26 d",
  "jnz c 2",
  "jnz 1 5",
  "cpy 7 c",
  "inc d",
  "dec c",
  "jnz c -2",
  "cpy a c",
  "inc a",
  "dec b",
  "jnz b -2",
  "cpy c b",
  "dec d",
  "jnz d -6",
  "cpy 19 c",
  "cpy 14 d",
  "inc a",
  "dec d",
  "jnz d -2",
  "dec c",
  "jnz c -5",
];

main(List<String> args) {
  // A - After executing the assembunny code in your puzzle input, what value
  // is left in register a?
  Map<String, int> register = new Map();
  register["a"] = 0;
  register["b"] = 0;
  register["c"] = 0;
  register["d"] = 0;
  print("Answer A: ${runProgram(input, register)}");

  // B - If you instead initialize register c to be 1, what value is now left
  // in register a?
  register["a"] = 0;
  register["b"] = 0;
  register["c"] = 1;
  register["d"] = 0;
  print("Answer B: ${runProgram(input, register)}");
}

int runProgram(List<String> program, Map<String, int> register) {
  int pos = 0;

  while (pos < program.length) {
    List<String> command = program[pos].split(" ");

    if (command[0] == "cpy") {
      int value = getValue(command[1], register);
      String reg = command[2];
      register[reg] = value;
    } else if (command[0] == "inc") {
      String reg = command[1];
      register[reg]++;
    } else if (command[0] == "dec") {
      String reg = command[1];
      register[reg]--;
    } else if (command[0] == "jnz") {
      int value = getValue(command[1], register);

      if (value != 0) {
        pos += getValue(command[2], register);
        continue;
      }
    }

    pos++;
  }

  return register["a"];
}

int getValue(String input, Map<String, int> register) {
  return int.parse(input, onError: (String source) => register[source]);
}
