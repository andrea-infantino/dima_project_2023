import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dima_project_2023/src/db_snapshot.dart';
import 'package:dima_project_2023/src/logic/achievements.dart';

// Mock class for DBsnapshot
class MockDBsnapshot extends Mock implements DBsnapshot {}

void main() {

  setUp(() {

    DBsnapshot.init();
    DBsnapshot.instance.score.value = 500;
    DBsnapshot.instance.social.value["friends"] = ['friend1', 'friend2'];
    Achievements.init();
  });
  test('Achievement initialization populates active and completed lists correctly', () {
    // Verify active achievements
    List<Achievement> active = Achievements.instance.active;
    expect(active.length, 2);
    expect(active[0].description, 'Reach 1000 beats');
    expect(active[0].currValue, 500);
    expect(active[0].maxValue, 1000);
    expect(active[1].description, 'Add 3 friends');
    expect(active[1].currValue, 2);
    expect(active[1].maxValue, 3);

    // Verify completed achievements
    List<Achievement> completed = Achievements.instance.completed;
    expect(completed.length, 2);
    expect(completed[0].description, 'Add 1 friends');
    expect(completed[0].currValue, 1);
    expect(completed[0].completed, true);
  });
  test('Achievements initialization populates active and completed lists correctly', () {
    // Verify active achievements
    List<Achievement> active = Achievements.instance.active;
    expect(active.length, 2);
    expect(active[0].description, 'Reach 1000 beats');
    expect(active[0].currValue, 500);
    expect(active[0].maxValue, 1000);
    expect(active[1].description, 'Add 3 friends');
    expect(active[1].currValue, 2);
    expect(active[1].maxValue, 3);
    // Verify completed achievements
    List<Achievement> completed = Achievements.instance.completed;
    expect(completed.length, 2);
    expect(completed[0].description, 'Add 1 friends');
    expect(completed[0].currValue, 1);
    expect(completed[0].maxValue, 1);
    expect(completed[0].completed, true);
  });
}