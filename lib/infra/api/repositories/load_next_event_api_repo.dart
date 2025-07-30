import 'package:advanced_flutter/domain/entities/errors.dart';
import 'package:advanced_flutter/domain/entities/next_event.dart';
import 'package:advanced_flutter/infra/api/clients/http_get_client.dart';
import 'package:advanced_flutter/infra/mappers/mapper.dart';

//use-case deletado
// final class LoadNextEventApiRepository implements LoadNextEventRepository {
final class LoadNextEventApiRepository {
  final HttpGetClient httpClient;
  final String url;
  final DtoMapper<NextEvent> mapper;

  const LoadNextEventApiRepository({
    required this.httpClient,
    required this.url,
    required this.mapper
  });

  //use-case deletado
  // @override
  Future<NextEvent> loadNextEvent({ required String groupId }) async {
    final json = await httpClient.get(url: url, params: { 'groupId': groupId });
    if (json == null) throw UnexpectedError();
    return mapper.toDto(json);
  }

}