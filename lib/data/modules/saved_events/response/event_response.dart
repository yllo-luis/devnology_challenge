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
    accessibility = json['accessibility'];
    type = json['type'];
    participants = json['participants'];
    price = json['price'];
    link = json['link'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity'] = super.activity;
    data['accessibility'] = super.accessibility;
    data['type'] = super.type;
    data['participants'] = super.participants;
    data['price'] = super.price;
    data['link'] = super.link;
    data['key'] = super.key;
    return data;
  }
}
