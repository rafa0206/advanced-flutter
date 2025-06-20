import 'package:advanced_flutter/domain/entities/next_event_player.dart';
import 'package:advanced_flutter/infra/cache/mappers/mapper.dart';
import 'package:advanced_flutter/infra/types/json.dart';

final class NextEventPlayerMapper extends Mapper<NextEventPlayer> {

  @override
  NextEventPlayer toObject(dynamic json) => NextEventPlayer(
        id: json['id'],
        name: json['name'],
        position: json['position'],
        photo: json['photo'],
        confirmationDate: json['confirmationDate'],
        isConfirmed: json['isConfirmed'],
      );

  JsonArr toJsonArr(List<NextEventPlayer> players) => players.map(toJson).toList();

  Json toJson(NextEventPlayer player) => {
    'id': player.id,
    'name': player.name,
    'position': player.position,
    'photo': player.photo,
    'confirmationDate': player.confirmationDate,
    'isConfirmed': player.isConfirmed
  };

}
