
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'DbAdapter.dart';

part 'Database.g.dart';

@Database(version: 1, entities: [Active,UnSelected])
abstract class AppDatabase extends FloorDatabase {
  ActiveDao get activeDao;
  UnSelectedDao get unSelectedDao;
}