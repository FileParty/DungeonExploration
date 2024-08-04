
import 'package:gemini_survival/src/dto/common/item_type.dart';
import 'package:gemini_survival/src/dto/item/item.dart';

class EscapeScroll extends Item {

  final EscapeScrollType type;
  
  EscapeScroll({
    required super.name,
    required super.description,
    required super.price,
    required this.type,
  });
}