// lib/models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final bool isPremium;
  int dailyCount;
  int bonusCount;          // bonus from rewarded ads
  final DateTime? dailyCountReset;
  final int freeLimit;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.isPremium = false,
    this.dailyCount = 0,
    this.bonusCount = 0,
    this.dailyCountReset,
    this.freeLimit = 5,
    required this.createdAt,
  });

  int get totalAllowed => freeLimit + bonusCount;
  bool get canGenerate => isPremium || dailyCount < totalAllowed;
  int get remaining => isPremium ? 999 : (totalAllowed - dailyCount).clamp(0, 999);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid:             doc.id,
      email:           data['email'] ?? '',
      displayName:     data['displayName'] ?? '',
      isPremium:       data['isPremium'] ?? false,
      dailyCount:      data['dailyCount'] ?? 0,
      bonusCount:      data['bonusCount'] ?? 0,
      dailyCountReset: data['dailyCountReset'] != null
          ? (data['dailyCountReset'] as Timestamp).toDate()
          : null,
      freeLimit:       data['freeLimit'] ?? 5,
      createdAt:       (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'uid':             uid,
    'email':           email,
    'displayName':     displayName,
    'isPremium':       isPremium,
    'dailyCount':      dailyCount,
    'bonusCount':      bonusCount,
    'dailyCountReset': dailyCountReset != null
        ? Timestamp.fromDate(dailyCountReset!)
        : null,
    'freeLimit':       freeLimit,
    'createdAt':       Timestamp.fromDate(createdAt),
  };
}
