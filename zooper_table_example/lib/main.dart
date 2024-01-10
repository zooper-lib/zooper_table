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
      body: Center(
        child: ZooperTable<TestData>(
          tableConfiguration: TableConfiguration(
            columnHeaderConfiguration: ColumnConfiguration(
              minWidthBuilder: (identifier) => 50,
              maxWidthBuilder: (identifier) => 200,
              canSort: (identifier) => true,
            ),
            rowConfiguration: RowConfiguration(),
            cellConfiguration: CellConfiguration<TestData>(
              cellValue: (TestData data, String identifier) {
                if (identifier == 'id') return data.id;
                if (identifier == 'name') return data.name;
                if (identifier == 'age') return data.age.toString();
                if (identifier == 'height') return data.height.toString();
                return '';
              },
            ),
          ),
          columns: [
            ZooperColumnModel(identifier: 'id', title: 'ID', order: 0),
            ZooperColumnModel(identifier: 'name', title: 'Name', order: 1),
            ZooperColumnModel(identifier: 'age', title: 'Age', order: 2),
            ZooperColumnModel(identifier: 'height', title: 'Height', order: 3),
          ],
          data: [
            TestData(id: '1', name: 'Test 1 with some more text than usual', age: 1, height: 1.1),
            TestData(id: '2', name: 'Test 2', age: 2, height: 2.2),
            TestData(id: '3', name: 'Test 3', age: 3, height: 3.3),
            TestData(id: '4', name: 'Test 4', age: 4, height: 4.4),
          ],
        ),
      ),
    );
  }
}
