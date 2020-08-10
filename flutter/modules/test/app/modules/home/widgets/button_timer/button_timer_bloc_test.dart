import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modules/app/app_module.dart';
import 'package:modules/app/modules/home/widgets/button_timer/button_timer_bloc.dart';
import 'package:modules/app/modules/home/home_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(HomeModule());
  ButtonTimerBloc bloc;

  // setUp(() {
  //     bloc = HomeModule.to.get<ButtonTimerBloc>();
  // });

  // group('ButtonTimerBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<ButtonTimerBloc>());
  //   });
  // });
}
