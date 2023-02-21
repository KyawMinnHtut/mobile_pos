import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:mobile_pos/simple_bloc_observer.dart';
import 'package:pos_api_impl/pos_api_impl.dart';
import 'package:pos_repository/pos_repository.dart';

import 'app.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final api = DatabaseImpl();
  final posRepository = PosRepository(api: api);
  runApp(App(posReopository: posRepository,));
}
