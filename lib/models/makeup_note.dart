class MakeupNote {
  final int makeupId;
  final String note;
  final int rating;
  final DateTime updatedAt;
  final bool pendingSync;

  const MakeupNote({
    required this.makeupId,
    required this.note,
    required this.rating,
    required this.updatedAt,
    this.pendingSync = true,
  });

  factory MakeupNote.fromJson(Map<String, dynamic> json) {
    return MakeupNote(
      makeupId: json['makeup_id'] as int,
      note: json['note'] as String,
      rating: json['rating'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'makeup_id': makeupId,
    'note': note,
    'rating': rating,
    'updated_at': updatedAt.toIso8601String(),
  };
}
