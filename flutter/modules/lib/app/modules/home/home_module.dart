import 'widgets/alert/alert_bloc.dart';
import 'widgets/dropdown_button/dropdown_button_bloc.dart';
import 'widgets/listview_horizontal/listview_horizontal_bloc.dart';
import 'widgets/button_timer/button_timer_bloc.dart';
import 'widgets/drawer/drawer_bloc.dart';
import 'home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AlertBloc()),
        Bind((i) => DropdownButtonBloc()),
        Bind((i) => ListviewHorizontalBloc()),
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
