import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/core/errors/exceptions.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/data/models/purchase_model.dart';
import 'package:event_app/global/utils/app_api.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

abstract class EventRemoteDataSource {
  Future<Unit> createEvent({
    required String userId,
    required String eventName,
    required String eventDate,
    required String eventLocation,
    required String eventPrice,
    required String eventAvailableTicket,
    required String eventDescription,
    File? eventImage,
  });

  Future<List<EventModel>> getAllEvents();

  Future<List<PurchaseModel>> getPurchasesByUser({
    required String userId,
  });

  Future<Unit> makeEventPurchase({
    required String eventId,
    required String userId,
    required int nbrTickets,
  });
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  EventRemoteDataSourceImpl({
    required http.Client client,
  }) : _client = client;
  final http.Client _client;

  @override
  Future<Unit> createEvent({
    required String userId,
    required String eventName,
    required String eventDate,
    required String eventLocation,
    required String eventPrice,
    required String eventAvailableTicket,
    required String eventDescription,
    File? eventImage,
  }) async {
    // Parse the date string
    final format = DateFormat('dd.MM.yyyy');
    final dateTime = format.parse(eventDate);

    final request = http.MultipartRequest(
      'POST',
      Uri.parse(createEventUrl),
    );

    final headers = <String, String>{'Content-type': 'multipart/form-data'};

    request.headers.addAll(headers);

    // Set request fields
    request.fields['name'] = eventName;
    request.fields['user'] = userId;
    request.fields['date'] = dateTime.toIso8601String();
    request.fields['location'] = eventLocation;
    request.fields['price'] = eventPrice;
    request.fields['availableTickets'] = eventAvailableTicket;
    request.fields['description'] = eventDescription;

    // Add the file if provided
    if (eventImage != null) {
      final mimeType =
          lookupMimeType(eventImage.path) ?? 'application/octet-stream';
      final imageStream = http.ByteStream(eventImage.openRead());
      final length = await eventImage.length();
      final imageFile = http.MultipartFile(
        'eventCover',
        imageStream,
        length,
        filename: eventImage.path.split('/').last,
        contentType: MediaType.parse(mimeType),
      );
      request.files.add(imageFile);
    }

    try {
      final response =
          await request.send().timeout(const Duration(seconds: 60));

      // Extract response body
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        return unit;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<EventModel>> getAllEvents() async {
    final response = await _client.get(
      Uri.parse(fetchEventUrl),
      headers: {'Content-Type': 'application/json'},
    ).catchError(
      (e) => throw ServerException(),
    );
    if (response.statusCode == 200) {
      return decodeJsonResponse(response.body);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> makeEventPurchase({
    required String eventId,
    required String userId,
    required int nbrTickets,
  }) async {
    final requestBody = <String, dynamic>{
      'userId': userId,
      'eventId': eventId,
      'tickets': nbrTickets,
    };
    final response = await _client
        .post(
          Uri.parse(purchaseEventUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )
        .catchError(
          (e) => throw ServerException(),
        );

    if (response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 400) {
      throw WrongCredentialException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PurchaseModel>> getPurchasesByUser({
    required String userId,
  }) async {
    final requestBody = <String, dynamic>{
      'userId': userId,
    };

    final response = await _client
        .post(
          Uri.parse(getPurchasesByUserUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )
        .catchError(
          (e) => throw ServerException(),
        );

    print(response.body);
    if (response.statusCode == 200) {
      return eventHistoryModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  List<EventModel> decodeJsonResponse(String response) {
    final eventList = <EventModel>[];

    // Decode the JSON response
    final responseBody = json.decode(response) as Map<String, dynamic>;

    // Access the list of events
    final eventsJson = responseBody['events'] as List<dynamic>;

    // Loop through the list and process each event
    for (final eventJson in eventsJson) {
      // Convert each event JSON to a Dart Map and then to the EventModel
      final eventMap = eventJson as Map<String, dynamic>;
      final event = EventModel.fromJson(eventMap);

      eventList.add(event);
    }

    return eventList;
  }
}
