import 'widgets/button_timer/button_timer_bloc.dart';
import 'widgets/drawer/drawer_bloc.dart';
import 'home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ButtonTimerBloc()),
        Bind((i) => DrawerBloc()),
        Bind((i) => HomeBloc()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}