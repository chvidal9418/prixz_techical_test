import 'package:bloc/bloc.dart';


class LoaderCubit extends Cubit<bool> {


  LoaderCubit() : super(false);

  void toggleLoader(bool isVisible) {
    emit(isVisible);
  }


}

