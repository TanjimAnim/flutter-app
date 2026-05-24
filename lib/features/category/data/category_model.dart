class CategoryItem {
  final String id;
  final String title;
  final String shortDescription;
  final int displayOrder;
  final bool active;
  final String? parent;
  final String icon;
  final String cover;
  final String banner;
  final String createdAt;
  final String url;
  final String lastUpdateAt;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.displayOrder,
    required this.active,
    this.parent,
    required this.icon,
    required this.cover,
    required this.banner,
    required this.createdAt,
    required this.url,
    required this.lastUpdateAt,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['_id'] as String,
      title: json['title'] as String,
      shortDescription: json['shortDescription'] as String,
      displayOrder: json['displayOrder'] as int,
      active: json['active'] as bool,
      parent: json['parent'] as String?,
      icon: json['icon'] as String,
      cover: json['cover'] as String,
      banner: json['banner'] as String,
      createdAt: json['createdAt'] as String,
      url: json['url'] as String,
      lastUpdateAt: json['lastUpdateAt'] as String,
    );
  }
}
