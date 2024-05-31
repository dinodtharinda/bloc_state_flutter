import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});

  factory Person.fromJsonfac(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      age: json['age'],
    );
  }

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;

  @override
  String toString() => 'name = $name, age = $age';
}