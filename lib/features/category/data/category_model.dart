class CategoryItem {
  final String id;
  final String title;
  final String shortDescription;
  final int displayOrder;
  final bool active;
  final String? parent;
  final String? icon;
  final String? cover;
  final String? banner;
  final DateTime createdAt;
  final DateTime lastUpdateAt;
  final String url;
  final bool deleted;
  final dynamic deletedAt;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.displayOrder,
    required this.active,
    required this.parent,
    required this.icon,
    required this.cover,
    required this.banner,
    required this.createdAt,
    required this.lastUpdateAt,
    required this.url,
    required this.deleted,
    required this.deletedAt,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
    id: json["_id"],
    title: json["title"],
    shortDescription: json["shortDescription"],
    displayOrder: json["displayOrder"],
    active: json["active"],
    parent: json["parent"],
    icon: json["icon"],
    cover: json["cover"],
    banner: json["banner"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastUpdateAt: DateTime.parse(json["lastUpdateAt"]),
    url: json["url"],
    deleted: json["deleted"],
    deletedAt: json["deletedAt"],
  );
}
