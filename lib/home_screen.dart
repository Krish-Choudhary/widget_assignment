import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_assignment/custom_elevated_button.dart';
import 'package:widget_assignment/output.dart';
import 'package:widget_assignment/widgets_screen.dart';
import 'package:widget_assignment/bool_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Assignment App'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: const Color.fromARGB(255, 226, 237, 214),
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: 400,
                child: Consumer<WidgetSelectionModel>(
                  builder: (context, widgetSelection, _) {
                    return !widgetSelection.addWidget
                        ? Output(
                            button: widgetSelection.button,
                            image: widgetSelection.image,
                            text: widgetSelection.textbox,
                            noWidgets: widgetSelection.noWidgets,
                          )
                        : WidgetsScreen();
                  },
                ),
              ),
            ),
            if (!Provider.of<WidgetSelectionModel>(context).addWidget)
              SizedBox(height: 20),
            if (!Provider.of<WidgetSelectionModel>(context).addWidget)
              CustomElevatedButton(
                text: 'Add Widget',
                onTapFunction: () {
                  Provider.of<WidgetSelectionModel>(context, listen: false)
                      .toggleAddWidgets();
                },
              ),
            if (!Provider.of<WidgetSelectionModel>(context).addWidget)
              SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
