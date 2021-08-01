import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prixz_techical_test/features/location_tracker/domain/use_case/set_location_use_case.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/bloc/location_cubit/location_cubit.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/page/home.dart';

import 'package:prixz_techical_test/features/location_tracker/domain/use_case/user_location_use_case.dart';
import 'package:prixz_techical_test/locator.dart';

import 'features/location_tracker/presentation/bloc/loader_cubit/loader_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpDI();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoaderCubit(),
        ),
        BlocProvider(
          create: (_) => LocationCubit(
            getUserLocationUseCase: locator<GetUserLocationUseCase>(),
            setUserLocationUseCase: locator<SetUserLocationUseCase>(),
            loaderCubit: locator<LoaderCubit>(),
          ),
        ),
      ],
      child: buildMaterialApp(),
    );
  }

  buildMaterialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
