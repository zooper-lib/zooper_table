import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';

class ZooperColumnView extends StatefulWidget {
  final String identifier;

  ZooperColumnView({
    required this.identifier,
  }) : super(key: ValueKey('column:$identifier'));

  @override
  State<ZooperColumnView> createState() => _ZooperColumnViewState();
}

class _ZooperColumnViewState extends State<ZooperColumnView> {
  bool _isControlKeyPressed = false;

  @override
  void initState() {
    super.initState();

    // Handle the key presses
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<TableConfigurationNotifier, TableState, ColumnState, ColumnService>(
      builder: (context, tableConfigurationNotifier, tableState, columnStateNotifier, columnService, child) {
        final columnIndex = columnService.getAbsoluteColumnIndexByIdentifier(widget.identifier);

        final columnWidth = columnService.getColumnWidth(widget.identifier);
        final minWidth = tableConfigurationNotifier.currentState.columnConfiguration.minWidthBuilder(widget.identifier);
        final maxWidth = tableConfigurationNotifier.currentState.columnConfiguration.maxWidthBuilder(widget.identifier);

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
          ),
          child: SizedBox(
            width: columnWidth,
            child: Stack(
              children: [
                // Content
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: columnWidth,
                    padding:
                        tableConfigurationNotifier.currentState.columnConfiguration.paddingBuilder(widget.identifier),
                    decoration: BoxDecoration(
                      border: tableConfigurationNotifier.currentState.columnConfiguration
                          .borderBuilder(widget.identifier, columnIndex),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _title(context),
                        _sortIcon(context),
                      ],
                    ),
                  ),
                ),

                // Resize handle
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: ResizeHandleView(
                    columnIdentifier: widget.identifier,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context) {
    return Consumer3<TableConfigurationNotifier, ColumnState, ColumnService>(
      builder: (context, tableConfigurationNotifier, columnStateNotifier, columnService, child) {
        var column = columnStateNotifier.dataColumns.firstWhere((element) => element.identifier == widget.identifier);

        // The column index must be calculated by the
        var relativeColumnIndex = columnService.getRelativeColumnIndexByIdentifier(column.identifier);

        return Expanded(
          child: ReorderableDragStartListener(
            index: relativeColumnIndex,
            child: GestureDetector(
              onTap: () {
                if (_isControlKeyPressed) {
                  print('secondary sorting');
                  columnService.sortColumn(column.identifier, _isControlKeyPressed);
                } else {
                  print('primary sorting');
                  columnService.sortColumn(column.identifier, _isControlKeyPressed);
                }
              },
              child: Text(
                column.title,
                overflow: TextOverflow.ellipsis,
                style: tableConfigurationNotifier.currentState.columnConfiguration.textStyleBuilder(widget.identifier),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sortIcon(BuildContext context) {
    return Consumer4<TableConfigurationNotifier, TableState, ColumnState, ColumnService>(
      builder: (context, tableConfigurationNotifier, tableState, columnStateNotifier, columnService, child) {
        final column = columnStateNotifier.dataColumns.firstWhere((element) => element.identifier == widget.identifier);

        if (tableConfigurationNotifier.currentState.columnConfiguration.canSortBuilder(widget.identifier) == false) {
          return const SizedBox.shrink();
        }

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (_isControlKeyPressed) {
                print('secondary sorting');
                columnService.sortColumn(column.identifier, true);
              } else {
                print('primary sorting');
                columnService.sortColumn(column.identifier, false);
              }
            },
            child: _getSortIcon(tableConfigurationNotifier.currentState, tableState),
          ),
        );
      },
    );
  }

  Widget _getSortIcon(TableConfiguration tableConfiguration, TableState tableState) {
    // If the column is not sorted, return an empty widget
    if (widget.identifier != tableState.currentState.primaryColumnSort?.identifier &&
        widget.identifier != tableState.currentState.secondaryColumnSort?.identifier) {
      return const SizedBox.shrink();
    }

    return widget.identifier == tableState.currentState.primaryColumnSort?.identifier
        ? _primarySortIcon(tableConfiguration, tableState)
        : _secondarySortIcon(tableConfiguration, tableState);
  }

  Widget _primarySortIcon(TableConfiguration tableConfiguration, TableState tableState) {
    // If the column cannot be sorted, we don't show the icon
    if (tableConfiguration.columnConfiguration.canSortBuilder(widget.identifier) == false) {
      return const SizedBox.shrink();
    }

    final columnSortOrder = tableState.currentState.primaryColumnSort == null
        ? null
        : tableState.currentState.primaryColumnSort?.identifier != widget.identifier
            ? null
            : tableState.currentState.primaryColumnSort?.sortOrder;

    return columnSortOrder == null
        ? const SizedBox.shrink()
        : columnSortOrder == SortOrder.descending
            ? tableConfiguration.columnConfiguration.primarySortDescendingIconBuilder(widget.identifier)
            : tableConfiguration.columnConfiguration.primarySortAscendingIconBuilder(widget.identifier);
  }

  Widget _secondarySortIcon(TableConfiguration tableConfiguration, TableState tableState) {
    // If the column cannot be sorted, we don't show the icon
    if (tableConfiguration.columnConfiguration.canSortBuilder(widget.identifier) == false) {
      return const SizedBox.shrink();
    }

    final columnSortOrder = tableState.currentState.secondaryColumnSort == null
        ? null
        : tableState.currentState.secondaryColumnSort?.identifier != widget.identifier
            ? null
            : tableState.currentState.secondaryColumnSort?.sortOrder;

    return columnSortOrder == null
        ? const SizedBox.shrink()
        : columnSortOrder == SortOrder.descending
            ? tableConfiguration.columnConfiguration.secondarySortDescendingIconBuilder(widget.identifier)
            : tableConfiguration.columnConfiguration.secondarySortAscendingIconBuilder(widget.identifier);
  }

  void _handleKeyPress(RawKeyEvent event) {
    setState(() {
      _isControlKeyPressed = event.isControlPressed;
    });
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyPress);
    super.dispose();
  }
}
