// --- Day 25: Clock Signal ---
// http://adventofcode.com/2016/day/25

List<String> input = [
  "cpy a d",
  "cpy 9 c",
  "cpy 282 b",
  "inc d",
  "dec b",
  "jnz b -2",
  "dec c",
  "jnz c -5",
  "cpy d a",
  "jnz 0 0",
  "cpy a b",
  "cpy 0 a",
  "cpy 2 c",
  "jnz b 2",
  "jnz 1 6",
  "dec b",
  "dec c",
  "jnz c -4",
  "inc a",
  "jnz 1 -7",
  "cpy 2 b",
  "jnz c 2",
  "jnz 1 4",
  "dec b",
  "dec c",
  "jnz 1 -4",
  "jnz 0 0",
  "out b",
  "jnz a -19",
  "jnz 1 -21",
];

main(List<String> args) {
  Map<String, int> register = new Map();

  for (int i = 0; i < 10000; i++) {
    register["a"] = i;
    register["b"] = 0;
    register["c"] = 0;
    register["d"] = 0;

    int next = 0;
    int count = 0;
    for (int output in runProgram(input, register)) {
      if (output == next) {
        if (++count > 100) {
          print("$i works!");
          return;
        }
        next = (next == 0) ? 1 : 0;
      } else {
        print("$i did not work!");
        break;
      }
    }
  }
}

Iterable<int> runProgram(
    List<String> program, Map<String, int> register) sync* {
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
    } else if (command[0] == "out") {
      yield getValue(command[1], register);
    } else {
      throw command;
    }

    pos++;
  }

  yield -1;
}

int getValue(String input, Map<String, int> register) {
  return int.parse(input, onError: (String source) => register[source]);
}
