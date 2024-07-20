import 'package:clean_arch_soccer_flutter/domain/entities/next_event_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String initialsOf(String name) =>
      NextEventPlayer(id: '', name: name, isConfirmed: true).initials;

  test('should return the first letter of the first and last names', () async {
    expect(initialsOf('Leo Silva'), 'LS');
    expect(initialsOf('Ramona Pulada'), 'RP');
    expect(initialsOf('Ingrid Motta das Virgens'), 'IV');
  });

  test('should return the first letter of the first name', () async {
    expect(initialsOf('Leo'), 'LE');
    expect(initialsOf('R'), 'R');
  });

  test('should return "-" when name is empty', () async {
    expect(initialsOf(''), '-');
  });

  test('should convert to uppercase', () async {
    expect(initialsOf('Leo'), 'LE');
    expect(initialsOf('leo silva'), 'LS');
    expect(initialsOf('Ramona rabuda quicada'), 'RQ');
    expect(initialsOf('r'), 'R');
  });

  test('should ignore extra whitespaces', () async {
    expect(initialsOf('Leo Silva   '), 'LS');
    expect(initialsOf('    Leo Silva   '), 'LS');
    expect(initialsOf('    Leo Silva  '), 'LS');
    expect(initialsOf('    Leo      Silva   '), 'LS');
    expect(initialsOf(' r '), 'R');
    expect(initialsOf(' '), '-');
    expect(initialsOf('   '), '-');
  });
}
