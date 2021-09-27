import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              // print(selectedValue);
              if (selectedValue == FilterOptions.Favorites) {
                productsContainer.showFavoritesOnly();
              }
              else {
                productsContainer.showAll();
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Only favorites'), value: FilterOptions.Favorites,),
              PopupMenuItem(child: Text('Show all'), value: FilterOptions.All,),
            ],
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
