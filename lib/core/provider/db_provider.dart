

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/data/datasource/database_helper.dart';

final localSourceProvider = Provider<DatabaseHelper>((ref)=>DatabaseHelper());