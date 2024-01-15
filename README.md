# Zooper Table

Zooper Table is a highly versatile and dynamic table widget for Flutter applications. It offers a range of features to enhance the usability and interactivity of tables in your app.

## Features

- **Column Sorting**: Easily sort data in columns.
- **Secondary Sorting**: Additional sorting options for more complex data structures.
- **Drag & Drop Columns**: Reorganize your table with intuitive drag and drop, complemented by smooth animations.
- **Sticky Columns**: Keep essential columns in view while scrolling through large datasets.
- **Builder Initialization**: Customize your table with builder methods for greater flexibility.
- **Row Reordering**: Change row order with user-friendly drag options and fluid animations.
- **Single Row Selection**: Efficiently select individual rows. (Note: Multi-select functionality is in development and coming soon!)

## Getting Started

To use Zooper Table in your Flutter project, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  zooper_table: ^latest_version
```

## Dependencies
Zooper Table relies on the following dependencies:

- `provider`: For state management.
- `lucide_icons`: For a rich set of icons.

Ensure these are also included in your pubspec.yaml file.

## Usage
Here's a quick example to get you started with Zooper Table:

``` dart
import 'package:flutter/material.dart';
import 'package:zooper_table/zooper_table.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ZooperTable(
          // Your table data and configuration
        ),
      ),
    );
  }
}
```

## Future Features

This is the list of features which will be implemented in the future:

- Multi selection of rows
- Multi reordering of rows

## Contributing

Contributions to Zooper Table are welcome! Feel free to submit issues and pull requests on our GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.