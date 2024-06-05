import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_state_flutter/data/cart_items.dart';
import 'package:bloc_state_flutter/features/home/models/home_product_data.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
   on<CartInitialEvent>(cartInitialEvent);
   on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
  emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    if(cartItems.contains(event.product)){
      cartItems.remove(event.product);
    }
    emit(CartSuccessState(cartItems: cartItems));
  }
}
