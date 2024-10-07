import 'dart:convert';

import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/global/utils/functions.dart';

List<PurchaseModel> eventHistoryModelFromJson(String str) =>
    List<PurchaseModel>.from(
      (json.decode(str) as List<dynamic>).map(
        (x) => PurchaseModel.fromJson(x as Map<String, dynamic>),
      ),
    );

class PurchaseModel {
  PurchaseModel({
    this.id,
    this.user,
    this.event,
    this.tickets,
    this.totalPrice,
    this.purchaseDate,
    this.qrCodeUrl,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        id: json['_id'] as String?,
        user: json['user'] as String?,
        event: json['event'] == null
            ? null
            : EventModel.fromJson(
                json['event'] as Map<String, dynamic>,
              ),
        tickets: json['tickets'] as int?,
        totalPrice: double.tryParse(json['totalPrice'].toString()),
        purchaseDate: json['purchaseDate'] == null
            ? null
            : formatIsoDate(json['purchaseDate'] as String),
        qrCodeUrl: json['qrCodeUrl'] as String?,
      );
  final String? id;
  final String? user;
  final EventModel? event;
  final int? tickets;
  final double? totalPrice;
  final String? purchaseDate;
  final String? qrCodeUrl;
}
