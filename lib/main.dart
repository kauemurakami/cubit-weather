import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/app/cubits/weather/weather_cubit.dart';
import 'package:weather_cubit/app/data/repository/weather_repository.dart';
import 'package:weather_cubit/app/pages/weather_search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => WeatherCubit(FakeWeatherRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}
/*
### CHANGE NOTIFIER ###
class MyChangeNotifier extends ChangeNotifier {
  int field1;
  String field2;

  voidChangeState() {
    field2 = 'New Value';
    notifyListeners();
  }
}

#### CUBIT ####
class MyState {
  final int field1;
  final String field2;

  MyState(this.field1, this.field2);
}

class MyCubit extends Cubit<MyState> {
  MyCubit() : super(MyState(0, 'InitialValue'));

  void changeState() {
    emit(MyState(0, 'newValue'));
  }
}
*/
