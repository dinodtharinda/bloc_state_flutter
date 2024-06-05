import 'package:bloc_state_flutter/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_state_flutter/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) {
          return current is CartActionState;
        },
        buildWhen: (previous, current) {
          return current is! CartActionState;
        },
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final currentState = state as CartSuccessState;
              final cartItems = currentState.cartItems;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return CartTileWidget(
                    cartItem: cartItems[index],
                    cartBloc: cartBloc,
                  );
                },
                itemCount: cartItems.length,
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
