import 'package:equatable/equatable.dart';

class PromoBannerItem extends Equatable {
  final String id;
  final String title;
  final String discount;
  final String image;

  const PromoBannerItem({
    required this.id,
    required this.title,
    required this.discount,
    required this.image,
  });

  factory PromoBannerItem.fromJson(Map<String, dynamic> j) => PromoBannerItem(
    id: j['id'] as String,
    title: j['title'] as String,
    discount: j['discount'] as String,
    image: j['image'] as String,
  );

  @override
  List<Object?> get props => [id, title, discount, image];
}