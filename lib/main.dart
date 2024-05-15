import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weekly/data/repo/repo.dart';
import 'package:weekly/data/service/service.dart';
import 'app/my_app.dart';

void main() {
  runZonedGuarded(() {
    initService();
    initRepo();

    apiService.init();

    runApp(const MyApp());
  }, (error, stack) {
    debugPrintStack(stackTrace: stack);
  });
}
