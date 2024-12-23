import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatefulWidget {
  final String title;
  final void Function(bool) onChanged;
  final bool initialValue;

  const CustomCheckboxListTile({
    super.key,
    required this.title,
    required this.onChanged,
    this.initialValue = false,
  });

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged(_value);
      },
      leading: Checkbox(
        value: _value,
        shape: const CircleBorder(),
        onChanged: (val) {
          setState(() {
            _value = val!;
          });
          widget.onChanged(_value);
        },
      ),
      title: Text(widget.title),
    );
  }
}
