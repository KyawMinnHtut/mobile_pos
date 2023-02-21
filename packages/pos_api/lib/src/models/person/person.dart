import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends Equatable {
  final String name;
  final String phNumber;
  final String address;
  final bool isCustomer;

  const Person({
    required this.name,
    required this.phNumber,
    required this.address,
    required this.isCustomer,
  });

  factory Person.fromJson(Map<String, dynamic> json) =>
      _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  Person copyWith({
    String? name,
    String? phNumber,
    String? address,
    bool? isCustomer,
  }) {
    return Person(
        name: name ?? this.name,
        phNumber: phNumber ?? this.phNumber,
        address: address ?? this.address,
        isCustomer: isCustomer ?? this.isCustomer);
  }

  @override
  List<Object?> get props => [name, phNumber, address, isCustomer];
}
