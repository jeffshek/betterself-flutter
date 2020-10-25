import 'package:betterself_flutter/constants/form_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

getSupplementLogFormFields() {
  return [
    Padding(
      padding: DEFAULT_FORM_PADDING,
      child: FormBuilderDateTimePicker(
        attribute: "time",
        inputType: InputType.both,
        format: DateFormat("yyyy-MM-dd hh:mm a"),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          helperText: "",
          labelText: "Time",
        ),
      ),
    ),
    Padding(
      padding: DEFAULT_FORM_PADDING,
      child: FormBuilderTextField(
        attribute: "quantity",
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          helperText: "How many were taken?",
          labelText: "Quantity",
        ),
        validators: [
          FormBuilderValidators.numeric(),
          FormBuilderValidators.max(70),
        ],
      ),
    ),
    Padding(
      padding: DEFAULT_FORM_PADDING,
      child: FormBuilderTextField(
        minLines: 3,
        maxLines: 10,
        attribute: "notes",
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          helperText: "Notes - How did it feel? Any effect? etc.",
          labelText: "Notes",
        ),
        validators: [],
      ),
    ),
  ];
}
