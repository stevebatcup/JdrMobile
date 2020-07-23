import 'package:injectable/injectable.dart';

@injectable
class LessonsService {
  final String _name = "foobar";
  String get name => _name;
}
