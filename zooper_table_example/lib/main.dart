import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';
import 'package:zooper_table_example/random_generator.dart';
import 'package:zooper_table_example/test_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZooperTable(
        tableConfiguration: TableConfiguration(
          valueGetter: (data, identifier) {
            if (identifier == 'id') return data.id;
            if (identifier == 'name') return data.name;
            if (identifier == 'age') return data.age;
            if (identifier == 'height') return data.height;
            return '';
          },
          columnConfiguration: ColumnConfiguration(
            maxWidthBuilder: (identifier) => (identifier == 'id') ? 50 : 500,
            canResizeBuilder: (identifier) => (identifier == 'id') ? false : true,
            canSortBuilder: (identifier) => (identifier == 'age') ? false : true,
          ),
          rowConfiguration: RowConfiguration(),
          cellConfiguration: CellConfiguration(),
        ),
        columns: [
          ColumnData(identifier: 'id', title: 'ID', columnStick: ColumnStick.left),
          ColumnData(identifier: 'name', title: 'Name'),
          ColumnData(identifier: 'age', title: 'Age'),
          ColumnData(identifier: 'height', title: 'Height'),
        ],
        data: _customList,
      ),
    );
  }

  // ignore: unused_element
  List<dynamic> get _generatedList => List.generate(
        10,
        (index) => TestData(
          id: RandomGenerator.random.nextInt(1000).toString(),
          name: RandomGenerator.getRandomString(100),
          age: RandomGenerator.random.nextInt(100),
          height: RandomGenerator.random.nextDouble(),
        ),
      );

// ignore: unused_element
  List<dynamic> get _customList => [
        TestData(
          id: '1',
          name: 'John',
          age: 20,
          height: 1.8,
        ),
        TestData(
          id: '2',
          name: 'John',
          age: 30,
          height: 1.6,
        ),
        TestData(
          id: '3',
          name: 'John',
          age: 40,
          height: 1.7,
        ),
        TestData(
          id: '4',
          name: 'John',
          age: 50,
          height: 1.9,
        ),
        TestData(
          id: '5',
          name: 'Jane',
          age: 60,
          height: 2,
        ),
        TestData(
          id: '6',
          name: 'Jane',
          age: 70,
          height: 1.4,
        ),
        TestData(
          id: '7',
          name: 'Jane',
          age: 80,
          height: 2.1,
        ),
        TestData(
          id: '8',
          name: 'Jane',
          age: 90,
          height: 1.2,
        ),
        TestData(
          id: '9',
          name: 'Simon',
          age: 35,
          height: 1.2,
        ),
        TestData(
          id: '10',
          name: 'Simon',
          age: 45,
          height: 1.2,
        ),
        TestData(
          id: '11',
          name: 'Simon',
          age: 55,
          height: 1.6,
        ),
        TestData(
          id: '12',
          name: 'Simon',
          age: 65,
          height: 1.3,
        ),
      ];
}
