import 'package:bloc_state_flutter/bloc/bloc_actions.dart';
import 'package:bloc_state_flutter/bloc/person.dart';
import 'package:bloc_state_flutter/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(name: 'Foo', age: 10),
  Person(name: 'Bar', age: 20),
];

const mockedPersons2 = [
  Person(name: 'Foo', age: 10),
  Person(name: 'Bar', age: 20),
];

Future<Iterable<Person>> mockGetPersons1(String url) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String url) =>
    Future.value(mockedPersons2);

void main() {
  group(
    "Testing Bloc",
    () {
      //write our tests
      late PersonsBloc bloc;

      setUp(() {
        bloc = PersonsBloc();
      });

      blocTest<PersonsBloc, FetchResult?>(
        'Test initial State',
        build: () => bloc,
        // ignore: prefer_const_constructors
        verify: (bloc) => expect(
          bloc.state,
         null,
        ),
      );

      //fetch mock date (persons1) and compare it with FetchResult
      blocTest(
        'Mock retriving presonsf rom first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: 'dummy_url_1',
              loader: mockGetPersons1,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPersons1,
            isRetrivedFromCache: false,
          ),
          const FetchResult(
            persons: mockedPersons1,
            isRetrivedFromCache: true,
          )
        ],
      );

      //fetch mock date (persons2) and compare it with FetchResult
      blocTest(
        'Mock retriving presonsf rom first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonAction(
              url: 'dummy_url_2',
              loader: mockGetPersons2,
            ),
          );
          bloc.add(
            const LoadPersonAction(
              url: 'dummy_url_2',
              loader: mockGetPersons2,
            ),
          );
        },
        expect: () => [
          const FetchResult(
            persons: mockedPersons2,
            isRetrivedFromCache: false,
          ),
          const FetchResult(
            persons: mockedPersons2,
            isRetrivedFromCache: true,
          )
        ],
      );
    },
  );
}
