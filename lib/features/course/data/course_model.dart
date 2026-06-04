import 'dart:convert';

import 'package:flutter_application_1/features/category/data/category_model.dart';

List<Course> courseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

class Course {
  String id;
  String title;
  String shortDescription;
  String description;
  bool hasLiveClass;
  bool hasRecordedClass;
  int displayOrder;
  List<String> topics;
  List<Faq> faq;
  List<Teacher> teacher;
  Pricing pricing;
  List<String> liveClass;
  List<String> lesson;
  int accessDuration;
  List<CategoryItem> category;
  int courseDuration;
  int seatLimit;
  String? cover;
  String? banner;
  String difficultyLevel;
  bool active;
  Review review;
  String url;
  DateTime createdAt;
  DateTime lastUpdateAt;
  bool deleted;
  dynamic deletedAt;
  String unlockMode;
  String scope;
  int estimatedTimeToComplete;

  Course({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.hasLiveClass,
    required this.hasRecordedClass,
    required this.displayOrder,
    required this.topics,
    required this.faq,
    required this.teacher,
    required this.pricing,
    required this.liveClass,
    required this.lesson,
    required this.accessDuration,
    required this.category,
    required this.courseDuration,
    required this.seatLimit,
    this.cover,
    this.banner,
    required this.difficultyLevel,
    required this.active,
    required this.review,
    required this.url,
    required this.createdAt,
    required this.lastUpdateAt,
    required this.deleted,
    required this.deletedAt,
    required this.unlockMode,
    required this.scope,
    required this.estimatedTimeToComplete,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["_id"],
    title: json["title"],
    shortDescription: json["shortDescription"],
    description: json["description"],
    hasLiveClass: json["hasLiveClass"],
    hasRecordedClass: json["hasRecordedClass"],
    displayOrder: json["displayOrder"],
    topics: List<String>.from(json["topics"].map((x) => x)),
    faq: List<Faq>.from(json["faq"].map((x) => Faq.fromJson(x))),
    teacher: List<Teacher>.from(
      json["teacher"].map((x) => Teacher.fromJson(x)),
    ),
    pricing: Pricing.fromJson(json["pricing"]),
    liveClass: List<String>.from(json["liveClass"].map((x) => x)),
    lesson: List<String>.from(json["lesson"].map((x) => x)),
    accessDuration: json["accessDuration"],
    category: List<CategoryItem>.from(
      json["category"].map((x) => CategoryItem.fromJson(x)),
    ),
    courseDuration: json["courseDuration"],
    seatLimit: json["seatLimit"],
    cover: json["cover"],
    banner: json["banner"],
    difficultyLevel: json["difficultyLevel"],
    active: json["active"],
    review: Review.fromJson(json["review"]),
    url: json["url"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastUpdateAt: DateTime.parse(json["lastUpdateAt"]),
    deleted: json["deleted"],
    deletedAt: json["deletedAt"],
    unlockMode: json["unlockMode"],
    scope: json["scope"],
    estimatedTimeToComplete: json["estimatedTimeToComplete"],
  );
}

class Faq {
  String title;
  String answer;

  Faq({required this.title, required this.answer});

  factory Faq.fromJson(Map<String, dynamic> json) =>
      Faq(title: json["title"], answer: json["answer"]);
}

class Pricing {
  String type;
  int? price;
  int? offerPrice;

  Pricing({required this.type, this.price, this.offerPrice});

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    type: json["type"],
    price: json["price"],
    offerPrice: json["offerPrice"],
  );
}

class Review {
  double rating;
  int count;

  Review({required this.rating, required this.count});

  factory Review.fromJson(Map<String, dynamic> json) =>
      Review(rating: json["rating"]?.toDouble(), count: json["count"]);

  Map<String, dynamic> toJson() => {"rating": rating, "count": count};
}

class Teacher {
  String id;
  String name;
  List<String> expertise;
  List<String> category;
  String phone;
  String email;
  Education education;
  List<String> employmentType;
  List<String> workSite;
  CurrentOccupation currentOccupation;
  Address address;
  bool phoneVerified;
  bool emailVerified;
  bool active;
  bool profileVerified;
  String image;
  DateTime createdAt;
  DateTime lastUpdateAt;
  bool deleted;
  dynamic deletedAt;
  Review review;
  String teacherType;

  Teacher({
    required this.id,
    required this.name,
    required this.expertise,
    required this.category,
    required this.phone,
    required this.email,
    required this.education,
    required this.employmentType,
    required this.workSite,
    required this.currentOccupation,
    required this.address,
    required this.phoneVerified,
    required this.emailVerified,
    required this.active,
    required this.profileVerified,
    required this.image,
    required this.createdAt,
    required this.lastUpdateAt,
    required this.deleted,
    required this.deletedAt,
    required this.review,
    required this.teacherType,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    id: json["_id"],
    name: json["name"],
    expertise: List<String>.from(json["expertise"].map((x) => x)),
    category: List<String>.from(json["category"].map((x) => x!)),
    phone: json["phone"],
    email: json["email"],
    education: Education.fromJson(json["education"]),
    employmentType: List<String>.from(json["employmentType"].map((x) => x)),
    workSite: List<String>.from(json["workSite"].map((x) => x)),
    currentOccupation: CurrentOccupation.fromJson(json["currentOccupation"]),
    address: Address.fromJson(json["address"]),
    phoneVerified: json["phoneVerified"],
    emailVerified: json["emailVerified"],
    active: json["active"],
    profileVerified: json["profileVerified"],
    image: json["image"],
    createdAt: DateTime.parse(json["createdAt"]),
    lastUpdateAt: DateTime.parse(json["lastUpdateAt"]),
    deleted: json["deleted"],
    deletedAt: json["deletedAt"],
    review: Review.fromJson(json["review"]),
    teacherType: json["teacherType"],
  );
}

class Address {
  String address1;
  String address2;
  String city;

  Address({required this.address1, required this.address2, required this.city});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "address1": address1,
    "address2": address2,
    "city": city,
  };
}

class CurrentOccupation {
  String position;
  String teachingExperience;

  CurrentOccupation({required this.position, required this.teachingExperience});

  factory CurrentOccupation.fromJson(Map<String, dynamic> json) =>
      CurrentOccupation(
        position: json["position"],
        teachingExperience: json["teachingExperience"],
      );

  Map<String, dynamic> toJson() => {
    "position": position,
    "teachingExperience": teachingExperience,
  };
}

class Education {
  String ieltsBandScore;
  int passingYear;
  String institution;
  String level;

  Education({
    required this.ieltsBandScore,
    required this.passingYear,
    required this.institution,
    required this.level,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    ieltsBandScore: json["IELTSBandScore"],
    passingYear: json["passingYear"],
    institution: json["institution"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "IELTSBandScore": ieltsBandScore,
    "passingYear": passingYear,
    "institution": institution,
    "level": level,
  };
}
