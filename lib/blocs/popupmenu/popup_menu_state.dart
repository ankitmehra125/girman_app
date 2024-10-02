import 'package:equatable/equatable.dart';

class PopupMenuState extends Equatable
{
  final String selectedItem;

  const PopupMenuState({required this.selectedItem});

  @override
  List<Object> get props {
    return [selectedItem];
  }
}