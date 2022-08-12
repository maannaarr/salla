import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'i_state.dart';

class ICubit extends Cubit<IState> {
  ICubit() : super(IInitial());
}
