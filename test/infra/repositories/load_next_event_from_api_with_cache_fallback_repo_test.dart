import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:advanced_flutter/infra/cache/mappers/next_event_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/fakes.dart';

final class LoadNextEventFromApiWithCacheFallbackRepository {
  final Future<NextEvent> Function({ required String groupId }) loadNextEventFromApi;
  final CacheSaveClient cacheClient;
  final String key;

  const LoadNextEventFromApiWithCacheFallbackRepository({
    required this.loadNextEventFromApi,
    required this.cacheClient,
    required this.key
  });

  Future<void> loadNextEvent({ required String groupId }) async {
    final event = await loadNextEventFromApi(groupId: groupId);
    final json = NextEventMapper().toJson(event);
    await cacheClient.save(key: '$key:$groupId', value: json);
  }
}

final class LoadNextEventRepositorySpy {
  String? groupId;
  int callsCount = 0;
  NextEvent output = NextEvent(groupName: anyString(), date: anyDate(), players: []);

  Future<NextEvent> loadNextEvent({ required String groupId }) async {
    this.groupId = groupId;
    callsCount++;
    return output;
  }
}

abstract interface class CacheSaveClient {
  Future<void> save({ required String key, required dynamic value });
}

final class CacheSaveClientSpy implements CacheSaveClient {
  String? key;
  dynamic value;

  @override
  Future<void> save({ required String key, required dynamic value }) async {
    this.key = key;
    this.value = value;
  }
}

void main() {

  late String groupId;
  late String key;
  late LoadNextEventRepositorySpy apiRepo;
  late CacheSaveClientSpy cacheClient;
  late LoadNextEventFromApiWithCacheFallbackRepository sut;

  setUp(() {
    groupId = anyString();
    key = anyString();
    apiRepo = LoadNextEventRepositorySpy();
    cacheClient = CacheSaveClientSpy();
    sut = LoadNextEventFromApiWithCacheFallbackRepository(
        key: key,
        cacheClient: cacheClient,
        loadNextEventFromApi: apiRepo.loadNextEvent,
    );
  });

  test('should load event data from api repo', () async {
    await sut.loadNextEvent(groupId: groupId);
    expect(apiRepo.groupId, groupId);
    expect(apiRepo.callsCount, 1);
  });

  test('should save event data from api on cache', () async {
    apiRepo.output = NextEvent(
        groupName: anyString(),
        date: anyDate(),
        players: [
          NextEventPlayer(id: anyString(), name: anyString(), isConfirmed: anyBool()),
          NextEventPlayer(id: anyString(), name: anyString(), isConfirmed: anyBool(), photo: anyString(), position: anyString(), confirmationDate: anyDate())
        ]
    );
    await sut.loadNextEvent(groupId: groupId);
    expect(cacheClient.key, '$key:$groupId');
    expect(cacheClient.value, {
      'groupName': apiRepo.output.groupName,
      'date': apiRepo.output.date,
      'players': [{
        'id': apiRepo.output.players[0].id,
        'name': apiRepo.output.players[0].name,
        'isConfirmed': apiRepo.output.players[0].isConfirmed,
        'photo': apiRepo.output.players[0].photo,
        'position': apiRepo.output.players[0].position,
        'confirmationDate': apiRepo.output.players[0].confirmationDate
      }, {
        'id': apiRepo.output.players[1].id,
        'name': apiRepo.output.players[1].name,
        'isConfirmed': apiRepo.output.players[1].isConfirmed,
        'photo': apiRepo.output.players[1].photo,
        'position': apiRepo.output.players[1].position,
        'confirmationDate': apiRepo.output.players[1].confirmationDate
      }]
    });
  });
}