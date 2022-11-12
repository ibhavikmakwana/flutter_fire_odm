import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createFieldMap: true,
)
class User {
  User({
    required this.name,
  });

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

  final String name;

  Map<String, Object?> toJson() => _$UserToJson(this);
}

@Collection<User>('users')
final usersRef = UserCollectionReference();
