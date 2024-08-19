


class GalleryItem {
  final String linkUrl;
  final String thumbnailUrl;
  final String title;

  const GalleryItem({
    required this.linkUrl,
    required this.thumbnailUrl,
    required this.title,
  });

  String get id => linkUrl.split('/').last;


}