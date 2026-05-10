import 'package:cloud_firestore/cloud_firestore.dart';

Timestamp? lastStoriesFetch;

DateTime? tryGetDateTimeFrom(Object? value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  if (value is Timestamp) return value.toDate();
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  return null;
}
