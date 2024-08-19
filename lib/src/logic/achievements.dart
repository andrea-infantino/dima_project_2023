import 'package:dima_project_2023/src/db_snapshot.dart';

class Achievement {
  late String _description;
  late int _currValue, _maxValue;
  late bool completed;

  Achievement._internal(String description, int maxValue, int currValue) {
    _description = description;
    _maxValue = maxValue;
    _currValue = currValue;
    completed = false;
  }

  get description => _description;

  get maxValue => _maxValue;

  get currValue => _currValue;
}

class Achievements {
  static late Achievements _achievements;
  static const N = 4;
  late List<Achievement> _active, _completed;

  static void init() {
    _achievements = Achievements._internal();
  }

  Achievements._internal() {
    _active = [];
    _completed = [];

    for (int i = 0; i < N; i++) {
      switch (i) {
        case 0:
          {
            int currValue = DBsnapshot.instance.score.value;
            int maxValue = 1000;
            if (currValue >= maxValue) {
              _completed.add(Achievement._internal(
                  'Reach 1000 beats', maxValue, maxValue));
            } else {
              _active.add(Achievement._internal(
                  'Reach 1000 beats', maxValue, currValue));
            }
            break;
          }
        case 1:
        case 2:
        case 3:
          {
            int currValue = DBsnapshot.instance.social.value["friends"]!.length;
            int maxValue = i;
            if (currValue >= maxValue) {
              _completed.add(Achievement._internal(
                  'Add $maxValue friends', maxValue, maxValue));
            } else {
              _active.add(Achievement._internal(
                  'Add $maxValue friends', maxValue, currValue));
            }
            break;
          }
        default:
          break;
      }
    }

    for (Achievement a in _completed) {
      a.completed = true;
    }
  }

  static Achievements get instance => _achievements;

  List<Achievement> get active => _active;

  List<Achievement> get completed => _completed;
}
