import 'package:hive/hive.dart';

@HiveType(typeId: 2)
enum ReadState {
@HiveField(0)
notRead,
@HiveField(1)
inProgress,
@HiveField(2)
read
}