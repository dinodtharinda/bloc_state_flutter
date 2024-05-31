import 'dart:convert';
import 'dart:io';

import 'package:bloc_state_flutter/bloc/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc/bloc_actions.dart';
import 'bloc/persons_bloc.dart';

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
                        url: persons1Url,
                        loader:getPerson 
                      ),
                    );
              },
              child: const Text("Load json #1"),
            ),
            TextButton(
              onPressed: () {
                context.read<PersonsBloc>().add(
                      const LoadPersonAction(
                        url:persons2Url,
                        loader: getPerson
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
