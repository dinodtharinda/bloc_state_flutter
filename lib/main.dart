import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (_) => PersonsBloc(),
        child: const HomePage(),
      ),
    ),
  );
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction extends LoadAction {
  final PersonUrl url;

  const LoadPersonAction({required this.url}) : super();
}

enum PersonUrl {
  persons1,
  persons2,
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.persons1:
        return "http://10.0.2.2:5500/api/persons1.json";
      case PersonUrl.persons2:
        return "http://10.0.2.2:5500/api/persons2.json";
    }
  }
}

@immutable
class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});

  factory Person.fromJsonfac(Map<String, dynamic> json) {
    return Person(
      name: json["name"],
      age: json["age"],
    );
  }

  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        age = json["age"] as int;

  @override
  String toString() => "name = $name, age = $age";
}

Future<Iterable<Person>> getPerson(String url) async => await HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

Future<Iterable<Person>> getPersonHttp(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Person.fromJson(json));
    } else {
      throw Exception('Failed to load persons: HTTP ${response.statusCode}');
    }
  } on SocketException catch (e) {
    print('FormatException: $e');
    throw Exception('Failed to load persons: Bad response format');
  } catch (e) {
    print('Unexpected error: $e');
    throw Exception('Failed to load persons due to unexpected error');
  }
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrivedFromCache,
  });

  @override
  String toString() =>
      "FetchResult(isRetrivedFromCashe = $isRetrivedFromCache, persons = $persons)";
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonAction>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          // we have the value in the cache
          final cachedPersons = _cache[url]!;
          final result = FetchResult(
            persons: cachedPersons,
            isRetrivedFromCache: true,
          );
          emit(result);
        } else {
          final persons = await getPersonHttp(url.urlString);
          _cache[url] = persons;
          final result =
              FetchResult(persons: persons, isRetrivedFromCache: false);
          emit(result);
        }
      },
    );
  }
}

extension Subscsript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(
                      const LoadPersonAction(
                        url: PersonUrl.persons1,
                      ),
                    );
              },
              child: const Text("Load json #1"),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(
                      const LoadPersonAction(
                        url: PersonUrl.persons2,
                      ),
                    );
              },
              child: const Text("Load json #2"),
            ),
          ],
        ),
        BlocBuilder<PersonsBloc, FetchResult?>(
          buildWhen: (previousResult, currentResult) {
            return previousResult?.persons != currentResult?.persons;
          },
          builder: (context, fetchResult) {
            final persons = fetchResult?.persons;
            if (persons == null) {
              return const SizedBox();
            }
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final person = persons[index]!;
                  return ListTile(
                    title: Text(person.name),
                  );
                },
                itemCount: persons.length,
              ),
            );
          },
        )
      ]),
    );
  }
}
