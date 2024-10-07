import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/global/utils/functions.dart';

EventModel eventModelFromJson(String str) => EventModel.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.id,
    this.user,
    this.name,
    this.date,
    this.location,
    this.price,
    this.availableTickets,
    this.description,
    this.eventCover,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['_id'] as String?,
        user: json['user'] as String?,
        name: json['name'] as String?,
        date:
            json['date'] == null ? null : formatIsoDate(json['date'] as String),
        location: json['location'] as String?,
        price: json['price'] != null
            ? double.tryParse(json['price'].toString())
            : null,
        availableTickets: json['availableTickets'] != null
            ? int.tryParse(json['availableTickets'].toString())
            : null,
        description: json['description'] as String?,
        eventCover: replaceLocalhost((json['eventCover'] as String?) ?? ''),
      );

  final String? id;
  final String? user;
  final String? name;
  final String? date;
  final String? location;
  final double? price;
  final int? availableTickets;
  final String? description;
  final String? eventCover;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'name': name,
        'date': date,
        'location': location,
        'price': price,
        'availableTickets': availableTickets,
        'description': description,
        'eventCover': eventCover,
      };

  DateTime getDate() {
    final dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.parse(date ?? '');
  }
}

String replaceLocalhost(String url) {
  return url.replaceAll('localhost', '10.0.2.2');
}
