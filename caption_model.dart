// lib/models/caption_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class CaptionModel {
  final String captionId;
  final String topic;
  final String platform;
  final String length;
  final bool includeHashtags;
  final String captionText;
  final List<String> hashtags;
  bool isFavorite;
  final DateTime generatedAt;

  CaptionModel({
    required this.captionId,
    required this.topic,
    required this.platform,
    required this.length,
    required this.includeHashtags,
    required this.captionText,
    required this.hashtags,
    this.isFavorite = false,
    required this.generatedAt,
  });

  factory CaptionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CaptionModel(
      captionId:       doc.id,
      topic:           data['topic'] ?? '',
      platform:        data['platform'] ?? '',
      length:          data['length'] ?? '',
      includeHashtags: data['includeHashtags'] ?? false,
      captionText:     data['captionText'] ?? '',
      hashtags:        List<String>.from(data['hashtags'] ?? []),
      isFavorite:      data['isFavorite'] ?? false,
      generatedAt:     (data['generatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'topic':           topic,
    'platform':        platform,
    'length':          length,
    'includeHashtags': includeHashtags,
    'captionText':     captionText,
    'hashtags':        hashtags,
    'isFavorite':      isFavorite,
    'generatedAt':     Timestamp.fromDate(generatedAt),
  };
}
