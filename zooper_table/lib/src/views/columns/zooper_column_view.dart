import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zooper_table/zooper_table.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ZooperColumnView extends StatelessWidget {
  /// Configuration for this [ZooperColumnView].
  final ColumnConfiguration columnConfiguration;

  /// The model for this column.
  final ZooperColumnModel model;

  /// Callback for how to generate the width for this column.
  final double Function()? widthBuilder;

  const ZooperColumnView({
    super.key,
    required this.columnConfiguration,
    required this.model,
    this.widthBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ColumnStateNotifier>(
      builder: (context, value, child) {
        final column = value.getColumn(model.identifier);

        final double minWidth = columnConfiguration.minWidthBuilder(column.identifier);
        final double maxWidth = columnConfiguration.maxWidthBuilder(column.identifier);

        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
          ),
          child: SizedBox(
            width: column.width,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    model.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                //const SizedBox.expand(),
                _resizeIcon(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _resizeIcon(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        onTap: () {},
        onHorizontalDragUpdate: (details) =>
            Provider.of<ColumnStateNotifier>(context, listen: false).updateColumnWidth(model, details.delta.dx),
        child: const Icon(
          LucideIcons.gripVertical,
          size: 16,
        ),
      ),
    );
  }
}
