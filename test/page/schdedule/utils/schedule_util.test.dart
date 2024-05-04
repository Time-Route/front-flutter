import 'package:flutter_test/flutter_test.dart';
import 'package:timeroute/page/schedule/controllers/schedule_controller.dart';
import 'package:timeroute/page/schedule/utils/schedule_util.dart';

void main() {
  group('ScheduleController', () {
    test('convertStartToInt', () {
      final testCases = {
        '0A': 0,
        '1B': 3,
        '2A': 4,
        '3B': 7,
        '0': 0,
        '1': 2,
        '2': 4,
        '3': 6,
      };

      testCases.forEach((input, expected) {
        expect(ScheduleUtil.convertStartToInt(input), expected);
      });
    });

    test('convertEndToInt', () {
      final testCases = {
        '0A': 0,
        '1B': 3,
        '2A': 4,
        '3B': 7,
        '0': 1,
        '1': 3,
        '2': 5,
        '3': 7,
      };

      testCases.forEach((input, expected) {
        expect(ScheduleUtil.convertEndToInt(input), expected);
      });
    });
  });
}
