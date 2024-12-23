import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_assignment/custom_elevated_button.dart';
import 'custom_list_tile.dart';
import 'bool_values.dart';

class WidgetsScreen extends StatelessWidget {
  const WidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WidgetSelectionModel>(
      builder: (context, widgetSelection, _) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CustomCheckboxListTile(
                    title: 'Textbox',
                    initialValue:
                        widgetSelection.textbox,
                    onChanged: (val) => widgetSelection
                        .toggleTextbox(val),
                  ),
                  CustomCheckboxListTile(
                    title: 'Image',
                    initialValue: widgetSelection.image,
                    onChanged: (val) => widgetSelection
                        .toggleImage(val),
                  ),
                  CustomCheckboxListTile(
                    title: 'Button',
                    initialValue: widgetSelection.button,
                    onChanged: (val) => widgetSelection
                        .toggleButton(val),
                  ),
                ],
              ),
            ),
            CustomElevatedButton(
              text: 'Import Widgets',
              onTapFunction: () {
                Provider.of<WidgetSelectionModel>(context, listen: false)
                    .toggleAddWidgets();
              },
            ),
            SizedBox(height: 40)
          ],
        );
      },
    );
  }
}
