import 'package:flutter/material.dart';
import 'package:e_commerce/pages/home.dart';
import 'package:e_commerce/pages/search.dart';
import 'package:e_commerce/pages/update.dart';
import 'package:e_commerce/pages/details.dart';
// import 'package:e_commerce/models/product.dart';
// ignore: depend_on_referenced_packages
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: '/search',
          pageBuilder: (context, state) {
            return _buildFadeTransition(state, const SearchPage());
          },
        ),
        GoRoute(
          path: '/update',
          pageBuilder: (context, state) {
            return _buildFadeTransition(state, const UpdatePage());
          },
        ),
        GoRoute(
          path: '/details/:id',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'];
            return _buildFadeTransition(state, Details(productId: int.parse(id!)));
          },
        ),
      ],
    ),
  ],
);



CustomTransitionPage _buildFadeTransition(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      // make the page rotate and fade in
      return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0), // Slide in from right
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );


    },
  );
}
