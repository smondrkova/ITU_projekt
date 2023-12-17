// Category.dart
class Category {
  final String id;
  final String name;
  String? photoUrl;

  Category({required this.id, required this.name, this.photoUrl});

  String getAssetPath() {
    return photoUrl ?? 'assets/placeholder.png';
  }
}
