import 'package:bloc_state_flutter/data/cart_items.dart';
import 'package:bloc_state_flutter/features/home/bloc/home_bloc.dart';
import 'package:bloc_state_flutter/features/home/models/home_product_data.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel product;
  final HomeBloc homeBloc;
  const ProductTileWidget({
    super.key,
    required this.product,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // height: 200,
      width: double.maxFinite,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset.zero,
            color: Color.fromARGB(255, 195, 195, 195),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Stack(
              children: [
                Image.network(
                  product.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 150,
                  color: const Color.fromARGB(83, 52, 52, 52),
                ),
                Positioned(
                  right: 7,
                  top: 7,
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      homeBloc.add(HomeProductWishListButtonClickedEvent(
                          clickedProduct: product));
                    },
                  ),
                ),
                Positioned(
                  left: 7,
                  top: 7,
                  child: IconButton(
                    icon: Icon(
                      cartItems.contains(product)
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      homeBloc.add(
                        HomeProductCartButtonClickedEvent(
                            clickedProduct: product,),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
