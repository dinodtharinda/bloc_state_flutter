// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_state_flutter/data/grocery_data.dart';
import 'package:bloc_state_flutter/features/home/models/home_product_data.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishListButtonClickedEvent>(
      homeProductWishListButtonClickedEvent,
    );
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
    HomeWishlistButtonNavigateEvent event,
    Emitter<HomeState> emit,
  ) {
    print('Wishlist Navigate Clicked ');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
    HomeCartButtonNavigateEvent event,
    Emitter<HomeState> emit,
  ) {
    print('Cart Navigate Clicked ');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(
    HomeProductWishListButtonClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    print('Clicked Product Wishlist');
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
    HomeProductCartButtonClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    print('Clicked Product Cart');
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(
      HomeLoadedSuccessState(
        products: GroceryData.groceryProducts.map((item) {
          return ProductDataModel.fromJson(item);
        }).toList(),
      ),
    );
    print(state);
  }
}
