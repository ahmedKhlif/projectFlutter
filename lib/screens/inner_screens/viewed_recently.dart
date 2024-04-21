import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:project/providers/viewed_prod_provider.dart';
import 'package:project/services/assets_manager.dart';
import 'package:project/services/my_app_method.dart';
import 'package:project/widgets/empty_bag.dart';
import 'package:project/widgets/products/products_widget.dart';
import 'package:project/widgets/title_text.dart';
import 'package:provider/provider.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = '/ViewedRecentlyScreen';
  const ViewedRecentlyScreen({super.key});
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
  final viewedProvider = Provider.of<ViewedProdProvider>(context);

    return viewedProvider.getviewedProdItems.isEmpty 
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your Viewed recently is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
           appBar: AppBar(
              title:  TitlesTextWidget(label: "Viewed recently (${viewedProvider.getviewedProdItems.length})"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                        MyAppMethods.showErrorORWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove items",
                        fct: () {
                          viewedProvider.clearLocalviewedProd();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: viewedProvider.getviewedProdItems.length,
              builder: ((context, index) {
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: viewedProvider.getviewedProdItems.values.toList()[index].productId,
                  ),
                );
              }),
              crossAxisCount: 2,
            ),
          );
  }
}
