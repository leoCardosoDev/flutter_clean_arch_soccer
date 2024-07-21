import '../entities/next_event.dart';
import '../repositories/load_next_event_repo.dart';

class NextEventLoader {
  final LoadNextEventRepository repo;
  NextEventLoader({required this.repo});

  Future<NextEvent> call({required String groupId}) async {
    return repo.loadNextEvent(groupId: groupId);
  }
}
