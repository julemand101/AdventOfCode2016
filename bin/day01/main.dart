// --- Day 1: No Time for a Taxicab ---
// http://adventofcode.com/2016/day/1

import 'dart:math';

const String input =
    "R1, L3, R5, R5, R5, L4, R5, R1, R2, L1, L1, R5, R1, L3, L5, L2, R4, L1, "
    "R4, R5, L3, R5, L1, R3, L5, R1, L2, R1, L5, L1, R1, R4, R1, L1, L3, R3, "
    "R5, L3, R4, L4, R5, L5, L1, L2, R4, R3, R3, L185, R3, R4, L5, L4, R48, "
    "R1, R2, L1, R1, L4, L4, R77, R5, L2, R192, R2, R5, L4, L5, L3, R2, L4, "
    "R1, L5, R5, R4, R1, R2, L3, R4, R4, L2, L4, L3, R5, R4, L2, L1, L3, R1, "
    "R5, R5, R2, L5, L2, L3, L4, R2, R1, L4, L1, R1, R5, R3, R3, R4, L1, L4, "
    "R1, L2, R3, L3, L2, L1, L2, L2, L1, L2, R3, R1, L4, R1, L1, L4, R1, L2, "
    "L5, R3, L5, L2, L2, L3, R1, L4, R1, R1, R2, L1, L4, L4, R2, R2, R2, R2, "
    "R5, R1, L1, L4, L5, R2, R4, L3, L5, R2, R3, L4, L1, R2, R3, R5, L2, L3, "
    "R3, R1, R3";


enum Direction { NORTH, EAST, SOUTH, WEST }

main(List<String> args) {
  Direction direction = Direction.NORTH;
  Set<Point> history = new Set<Point>();
  Point firstPointToVisitTwice = null;

  int x = 0;
  int y = 0;

  for (String part in input.split(", ")) {
    int length = int.parse(part.substring(1));
    direction = move(direction, part);

    switch (direction) {
      case Direction.NORTH:
        for (int i = 0; i < length; i++) {
          y += 1;

          if (firstPointToVisitTwice == null) {
            Point p = new Point(x, y);

            if (history.add(p) == false) {
              firstPointToVisitTwice = p;
            }
          }
        }
        break;
      case Direction.EAST:
        for (int i = 0; i < length; i++) {
          x += 1;

          if (firstPointToVisitTwice == null) {
            Point p = new Point(x, y);

            if (history.add(p) == false) {
              firstPointToVisitTwice = p;
            }
          }
        }
        break;
      case Direction.SOUTH:
        for (int i = 0; i < length; i++) {
          y -= 1;

          if (firstPointToVisitTwice == null) {
            Point p = new Point(x, y);

            if (history.add(p) == false) {
              firstPointToVisitTwice = p;
            }
          }
        }
        break;
      case Direction.WEST:
        for (int i = 0; i < length; i++) {
          x -= 1;

          if (firstPointToVisitTwice == null) {
            Point p = new Point(x, y);

            if (history.add(p) == false) {
              firstPointToVisitTwice = p;
            }
          }
        }
        break;
    }
  }

  print("x: ${x}, y: ${y}");
  print("Distance from start (0,0): ${x.abs() + y.abs()}");
  print("");
  print("First point to visit twice: $firstPointToVisitTwice");
  print("Distance from start (0,0): ${firstPointToVisitTwice.x.abs() +
    firstPointToVisitTwice.y.abs()}");
}

Direction move(Direction d, String move) {
  var left = (move[0] == "L") ? true : false;

  switch (d) {
    case Direction.NORTH:
      return (left) ? Direction.WEST : Direction.EAST;
    case Direction.EAST:
      return (left) ? Direction.NORTH : Direction.SOUTH;
    case Direction.SOUTH:
      return (left) ? Direction.EAST : Direction.WEST;
    case Direction.WEST:
      return (left) ? Direction.SOUTH : Direction.NORTH;
  }

  return null;
}
