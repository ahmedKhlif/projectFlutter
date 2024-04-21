import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/providers/cart_provider.dart';
import 'package:project/providers/product_provider.dart';
import 'package:project/providers/theme_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/providers/viewed_prod_provider.dart';
import 'package:project/providers/wishlist_provider.dart';
import 'package:project/screens/auth/forget_password.dart';
import 'package:project/screens/auth/login.dart';
import 'package:project/screens/auth/register.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/inner_screens/orders/orders_screen.dart';
import 'package:project/screens/inner_screens/porducts_details.dart';
import 'package:project/screens/inner_screens/viewed_recently.dart';
import 'package:project/screens/inner_screens/wishlist.dart';
import 'package:project/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';
import 'root_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: SelectableText(
                    "An error has been occured ${snapshot.error}"),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ThemeProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ProductProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => WishlistProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ViewedProdProvider(),
              ),
                ChangeNotifierProvider(
                create: (_) => UserProvider(),
              ),
            ],
            child: Consumer<ThemeProvider>(
              builder: (
                context,
                themeProvider,
                child,
              ) {
                return MaterialApp(
                  debugShowCheckedModeBanner:false,
                  title: 'Shop Smart AR',
                  theme: Styles.themeData(
                      isDarkTheme: themeProvider.getIsDarkTheme,
                      context: context),
                  home: const RootScreen(),
                  // home: const RegisterScreen(),
                  routes: {
                    ProductDetails.routName: (context) =>
                        const ProductDetails(),
                    WishlistScreen.routName: (context) =>
                        const WishlistScreen(),
                    ViewedRecentlyScreen.routName: (context) =>
                        const ViewedRecentlyScreen(),
                    RegisterScreen.routName: (context) =>
                        const RegisterScreen(),
                    LoginScreen.routName: (context) => const LoginScreen(),
                    OrdersScreenFree.routeName: (context) =>
                        const OrdersScreenFree(),
                    ForgotPasswordScreen.routeName: (context) =>
                        const ForgotPasswordScreen(),
                    SearchScreen.routeName: (context) => const SearchScreen(),
                    RootScreen.routName: (context) => const RootScreen(),
                  },
                );
              },
            ),
          );
        });
  }
}
