import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/app/cubits/weather/weather_cubit.dart';
import 'package:weather_cubit/app/data/model/weather_model.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WeatherSearch'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state is WeatherError) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('state.message')));
              }
            },
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(state.weather);
              } else {
                //create state erroeweather
                return buildLoading();
              }
            },
          ),
        ));
  }

  Widget buildInitialInput() {
    return CityInputField();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          '${weather.temperatureCelsius.toStringAsFixed(1)} ºC',
          style: TextStyle(fontSize: 60),
        ),
        CityInputField()
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
          onSubmitted: (value) => submitCityName(context, value),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              hintText: 'Enter a City',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: Icon(Icons.search)),
        ));
  }
}

void submitCityName(BuildContext context, String cityName) {
  final weatherCubit = context.bloc<WeatherCubit>();
  weatherCubit.getWeather(cityName);
}
