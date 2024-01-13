import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';
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
          ColumnData(identifier: 'id', title: 'ID'),
          ColumnData(identifier: 'name', title: 'Name'),
          ColumnData(identifier: 'age', title: 'Age'),
          ColumnData(identifier: 'height', title: 'Height'),
        ],
        data: List.generate(
          10,
          (index) => TestData(
            id: '$index',
            name: 'Test $index with some more text than usual',
            age: index,
            height: index.toDouble(),
          ),
        ),
      ),
    );
  }
}
