import 'package:bloc_state_flutter/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';

import '../../home/models/home_product_data.dart';

class CartTileWidget extends StatelessWidget {
  const CartTileWidget({
    super.key,
    required this.cartItem,
    required this.cartBloc,
  });

  final ProductDataModel cartItem;
  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.name),
      trailing: IconButton(
        icon: const Icon(
          Icons.remove_circle_outline_rounded,
          color: Colors.red,
        ),
        onPressed: () {
          cartBloc.add(CartRemoveFromCartEvent(product: cartItem),);
        },
      ),
    );
  }
}
