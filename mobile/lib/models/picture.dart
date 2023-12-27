class Picture {
  final int itemId;
  final String imageString;
  const Picture({required this.itemId, required this.imageString});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      itemId: json['item_id'] as int,
      imageString: json['image'] as String,
    );
  }
}
