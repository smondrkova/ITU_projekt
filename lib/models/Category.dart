// lib/models/Category.dart
/// Project: Evento
///
/// EventDetail page view.
///
/// 17.12.2023
///
/// @author Matej Tomko, xtomko06
///

class Category {
  final String id;
  final String name;
  String? photoUrl;

  Category({required this.id, required this.name, this.photoUrl});

  String getAssetPath() {
    return photoUrl ?? 'assets/placeholder.png';
  }
}
