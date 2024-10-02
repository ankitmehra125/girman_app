import 'package:equatable/equatable.dart';

abstract class PopupMenuEvent extends Equatable
{
  PopupMenuEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class SelectedMenuItem extends PopupMenuEvent
{
  final String selectedItem;

  SelectedMenuItem(this.selectedItem);

  @override
  List<Object> get props {
    return [selectedItem];
  }
}