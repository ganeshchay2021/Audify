import 'package:audify/presentation/auth/bloc/show_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPasswordCubit extends Cubit<ShowPasswordState> {
  ShowPasswordCubit() : super(ShowPasswordInitial());

  bool showPassword = true;

  void togglePassword() {
    showPassword = !showPassword;
    emit(ShowPasswordUpdated());
  }
}
