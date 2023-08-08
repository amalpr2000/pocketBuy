import 'package:flutter/material.dart';

class UserEditingController  {
  TextEditingController editingController = TextEditingController();
  UserEditingController({required String initialData}) {
    editingController.text = initialData;
  }
}