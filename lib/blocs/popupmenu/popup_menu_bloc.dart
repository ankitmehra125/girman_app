import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:girman_app/blocs/popupmenu/popup_menu_event.dart';
import 'package:girman_app/blocs/popupmenu/popup_menu_state.dart';

class PopupMenuBloc extends Bloc<PopupMenuEvent,PopupMenuState>
{
  PopupMenuBloc() : super(PopupMenuState(selectedItem: ""))
  {
    on<SelectedMenuItem>((event,emit){
      emit(PopupMenuState(selectedItem: event.selectedItem));
    });
  }
}