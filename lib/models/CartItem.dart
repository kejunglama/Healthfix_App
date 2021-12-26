import 'package:healthfix/models/Model.dart';

class CartItem extends Model {
  static const String PRODUCT_ID_KEY = "product_id";
  static const String ITEM_COUNT_KEY = "item_count";
  static const String VARIATION_KEY = "variation";

  int itemCount;
  Map variations;
  CartItem({
    String id,
    this.itemCount = 0,
    this.variations,
  }) : super(id);

  factory CartItem.fromMap(Map<String, dynamic> map, {String id, Map variations}) {
    return CartItem(
      id: id,
      itemCount: map[ITEM_COUNT_KEY],
      variations: variations,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      ITEM_COUNT_KEY: itemCount,
      VARIATION_KEY: variations,
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (itemCount != null) map[ITEM_COUNT_KEY] = itemCount;
    return map;
  }
}
