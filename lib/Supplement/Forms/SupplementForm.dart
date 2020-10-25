import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

getSupplementFormFields() {
  return [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        attribute: "name",
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Supplement Name",
        ),
        maxLines: 1,
        validators: [
          FormBuilderValidators.required(),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        minLines: 3,
        maxLines: 10,
        attribute: "notes",
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          helperText:
          "Notes abut the supplement. Is it for mental clarity, strength? etc.",
          labelText: "Supplement Notes",
        ),
        validators: [],
      ),
    ),
  ];
}