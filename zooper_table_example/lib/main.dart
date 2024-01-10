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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ZooperTable(
          tableConfiguration: TableConfiguration(
            columnHeaderConfiguration: ColumnConfiguration(
              minWidthBuilder: (identifier) => 50,
              maxWidthBuilder: (identifier) => 200,
              canSort: (identifier) => true,
            ),
            rowConfiguration: RowConfiguration(),
            cellConfiguration: CellConfiguration(
              cellValueBuilder: (data, String identifier) {
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
            TestData(id: '5', name: 'Test 5', age: 5, height: 5.5),
            TestData(id: '6', name: 'Test 6', age: 6, height: 6.6),
            TestData(id: '7', name: 'Test 7', age: 7, height: 7.7),
            TestData(id: '8', name: 'Test 8', age: 8, height: 8.8),
            TestData(id: '9', name: 'Test 9', age: 9, height: 9.9),
            TestData(id: '10', name: 'Test 10', age: 10, height: 10.10),
            TestData(id: '11', name: 'Test 11', age: 11, height: 11.11),
            TestData(id: '12', name: 'Test 12', age: 12, height: 12.12),
            TestData(id: '13', name: 'Test 13', age: 13, height: 13.13),
            TestData(id: '14', name: 'Test 14', age: 14, height: 14.14),
            TestData(id: '15', name: 'Test 15', age: 15, height: 15.15),
            TestData(id: '16', name: 'Test 16', age: 16, height: 16.16),
            TestData(id: '17', name: 'Test 17', age: 17, height: 17.17),
            TestData(id: '18', name: 'Test 18', age: 18, height: 18.18),
            TestData(id: '19', name: 'Test 19', age: 19, height: 19.19),
            TestData(id: '20', name: 'Test 20', age: 20, height: 20.20),
          ],
        ),
      ),
    );
  }
}
