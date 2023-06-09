import 'package:devnology_challenge/domain/entity/event_entity.dart';

class EventResponse extends EventEntity {
  EventResponse({
    super.activity,
    super.accessibility,
    super.type,
    super.participants,
    super.price,
    super.link,
    super.key,
  });

  EventResponse.fromJson(Map<String, dynamic> json) {
    activity = json['activity'];
    accessibility = json['accessibility'].toString();
    type = json['type'];
    participants = json['participants'].toString();
    price = json['price'].toString();
    link = json['link'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = super.key;
    data['activity'] = super.activity;
    data['accessibility'] = super.accessibility;
    data['type'] = super.type;
    data['participants'] = super.participants;
    data['price'] = super.price;
    data['link'] = super.link;
    return data;
  }
}
