part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({
    required this.products,
  });

  @override
  String toString() {
    return 'Product = $products';
  }
}

class HomeErrorState extends HomeState {}

// Action State

abstract class HomeActionState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {
  final ProductDataModel product;

  HomeProductItemWishlistedActionState(this.product);
}
class HomeProductItemCartedActionState extends HomeActionState {
  final ProductDataModel product;

  HomeProductItemCartedActionState(this.product);
  
}

