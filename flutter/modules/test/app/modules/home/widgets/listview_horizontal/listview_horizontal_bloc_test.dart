import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modules/app/app_module.dart';
import 'package:modules/app/modules/home/widgets/listview_horizontal/listview_horizontal_bloc.dart';
import 'package:modules/app/modules/home/home_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(HomeModule());
  ListviewHorizontalBloc bloc;

  // setUp(() {
  //     bloc = HomeModule.to.get<ListviewHorizontalBloc>();
  // });

  // group('ListviewHorizontalBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<ListviewHorizontalBloc>());
  //   });
  // });
}
