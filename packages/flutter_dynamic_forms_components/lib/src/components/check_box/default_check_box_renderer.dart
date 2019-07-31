import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dynamic_forms/flutter_dynamic_forms.dart';

import 'check_box.dart';

class DefaultCheckBoxRenderer extends FormElementRenderer<CheckBox> {
  @override
  Widget render(
      CheckBox element,
      BuildContext context,
      FormElementEventDispatcherFunction dispatcher,
      FormElementRendererFunction renderer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (value) => dispatcher(
                ChangeValueEvent(value: value, elementId: element.id)),
            value: element.value,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(element.label),
          )
        ],
      ),
    );
  }
}
