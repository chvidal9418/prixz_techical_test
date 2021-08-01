import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/bloc/loader_cubit/loader_cubit.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({Key key}) : super(key: key);

  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoaderCubit, bool>(
        listener: (_, state) {
          print(state);
        },
        builder: (_, state) {
          return state ? CircularProgressIndicator() : Container();
        });
  }
}
