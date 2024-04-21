
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:project/consts/app_constants.dart';
import 'package:project/providers/product_provider.dart';
import 'package:project/services/assets_manager.dart';
import 'package:project/widgets/app_name_text.dart';
import 'package:project/widgets/products/ctg_rounded_widget.dart';
import 'package:project/widgets/products/latest_arrival.dart';
import 'package:project/widgets/title_text.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
    static const routeName = '/HomeScreen';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),

                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: true,
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitlesTextWidget(
                label: "Latest arrival",
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value:productProvider.getProducts[index],
                        child: const LatestArrivalProductsWidget(),
                      );
                    }),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitlesTextWidget(
                label: "Categories",
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              GridView.count(
                padding:const EdgeInsetsDirectional.all(10.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  
                  children: List.generate(AppConstants.categoriesList.length,
                      (index) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].image,
                      name: AppConstants.categoriesList[index].name,
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
