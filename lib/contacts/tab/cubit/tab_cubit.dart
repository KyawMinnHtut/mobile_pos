import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState());

  void setTab(ContactsTab tab) => emit(TabState(tab: tab));
}
