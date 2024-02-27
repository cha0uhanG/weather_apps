// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/auth_bloc.dart' as _i3;
import 'application/weather/weather_bloc.dart' as _i5;
import 'domain/weather/dio_service.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthBloc>(() => _i3.AuthBloc());
    gh.factory<_i3.AuthBlocEvent>(() => _i3.AuthBlocEvent());
    gh.factory<_i3.AuthBlocState>(() => _i3.AuthBlocState());
    gh.factory<_i3.DataLoading>(() => _i3.DataLoading());
    gh.factory<_i3.DataValueFailed>(() => _i3.DataValueFailed(gh<String>()));
    gh.factory<_i4.DioService>(() => _i4.DioService());
    gh.factory<_i3.InitialState>(() => _i3.InitialState());
    gh.factory<_i5.InitialWeatherState>(() => _i5.InitialWeatherState());
    gh.factory<_i5.LoadingWeatherState>(() => _i5.LoadingWeatherState());
    gh.factory<_i3.PerformSignIn>(() => _i3.PerformSignIn(
          gh<String>(),
          gh<String>(),
        ));
    gh.factory<_i3.PerformSignUp>(() => _i3.PerformSignUp(
          gh<String>(),
          gh<String>(),
        ));
    gh.factory<_i5.SearchCityEvent>(() => _i5.SearchCityEvent(gh<String>()));
    gh.factory<_i5.SearchCityLocationEvent>(() => _i5.SearchCityLocationEvent(
          gh<String>(),
          gh<String>(),
        ));
    gh.factory<_i3.SignInCompleted>(() => _i3.SignInCompleted());
    gh.factory<_i3.SignUpCompleted>(() => _i3.SignUpCompleted());
    gh.factory<_i5.WeatherBloc>(() => _i5.WeatherBloc());
    gh.factory<_i5.WeatherBlocEvent>(() => _i5.WeatherBlocEvent());
    gh.factory<_i5.WeatherBlocState>(() => _i5.WeatherBlocState());
    gh.factory<_i5.WeatherState>(() => _i5.WeatherState());
    return this;
  }
}
