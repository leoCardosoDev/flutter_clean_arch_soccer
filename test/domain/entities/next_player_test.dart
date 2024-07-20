import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
  late final String initials;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationDate;

  NextEventPlayer(
      {required this.id,
      required this.name,
      required this.isConfirmed,
      this.photo,
      this.position,
      this.confirmationDate
      }) {
      initials = _getInitials();
    }

  String _getInitials() {
    final names = name.toUpperCase().split(' ');
    final firstChar = names.first.split('').firstOrNull ?? '-';
    final lastChar = names.last.split('').elementAtOrNull(names.length == 1 ? 1 : 0) ?? '';
    return '$firstChar$lastChar';
  }
}

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
}
