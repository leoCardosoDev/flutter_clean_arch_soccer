import 'dart:math';

import 'package:clean_arch_soccer_flutter/domain/entities/next_event.dart';
import 'package:clean_arch_soccer_flutter/domain/repositories/load_next_event_repo.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_arch_soccer_flutter/domain/entities/next_event_player.dart';



class NextEventLoader {
  final LoadNextEventRepository repo;
  NextEventLoader({required this.repo});

  Future<NextEvent> call({required String groupId}) async {
    return repo.loadNextEvent(groupId: groupId);
  }
}



class LoadNextEventSpyRepository implements LoadNextEventRepository {
  String? groupId;
  NextEvent? output;
  int callsCount = 0;
  Error? error;

  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    this.groupId = groupId;
    callsCount++;
    if (error != null) throw error!;
    return output!;
  }
}

void main() {
  late String groupId;
  late LoadNextEventSpyRepository repo;
  late NextEventLoader sut;

  setUp(() {
    groupId = Random().nextInt(5000).toString();
    repo = LoadNextEventSpyRepository();
    repo.output =
        NextEvent(groupName: 'any_group_name', date: DateTime.now(), players: [
      NextEventPlayer(
          id: 'any id 1',
          name: 'any name 1',
          isConfirmed: true,
          photo: 'any photo',
          confirmationDate: DateTime.now()),
      NextEventPlayer(
          id: 'any id 2',
          name: 'any name 2',
          isConfirmed: false,
          position: 'any position',
          confirmationDate: DateTime.now()),
    ]);
    sut = NextEventLoader(repo: repo);
  });

  test('should load event data from a repository', () async {
    await sut(groupId: groupId);
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });

  test('should return event data on success', () async {
    final event = await sut(groupId: groupId);
    expect(event.groupName, repo.output?.groupName);
    expect(event.date, repo.output?.date);
    expect(event.players.length, 2);
    expect(event.players[0].id, repo.output?.players[0].id);
    expect(event.players[0].name, repo.output?.players[0].name);
    expect(event.players[0].initials, isNotEmpty);
    expect(event.players[0].photo, repo.output?.players[0].photo);
    expect(event.players[0].isConfirmed, repo.output?.players[0].isConfirmed);
    expect(event.players[0].confirmationDate,
        repo.output?.players[0].confirmationDate);
    expect(event.players[1].id, repo.output?.players[1].id);
    expect(event.players[1].name, repo.output?.players[1].name);
    expect(event.players[1].initials, isNotEmpty);
    expect(event.players[1].position, repo.output?.players[1].position);
    expect(event.players[1].isConfirmed, repo.output?.players[1].isConfirmed);
    expect(event.players[1].confirmationDate,
        repo.output?.players[1].confirmationDate);
  });

  test('should rethrow on erro', () async {
    final error = Error();
    repo.error = error;
    final future = sut(groupId: groupId);
    expect(future, throwsA(error));
  });
}
