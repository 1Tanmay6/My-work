import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../notifiers/auth_notifiers.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthNotifiers()),
  ];
}
