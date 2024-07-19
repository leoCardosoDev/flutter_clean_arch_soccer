import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
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
      this.confirmationDate});

  String getInitials() {
    final names = name.split(' ');
    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar';
  }
}

void main() {
  NextEventPlayer makeSut(String name) => NextEventPlayer(id: '', name: name, isConfirmed: true);

  test('should return the first letter of the first and last names', () async {
    expect(makeSut('Leo Silva').getInitials(), 'LS');
    expect(makeSut('Ramona Pulada').getInitials(), 'RP');
    expect(makeSut('Ingrid Motta das Virgens').getInitials(), 'IV');
  });
}
