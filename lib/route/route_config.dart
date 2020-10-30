import 'package:flutter/material.dart';
import 'package:test_app/route/404_page.dart';

final Map<String, WidgetBuilder> namedRoutes = {
  // ///主页
  // ContainerPage.pageName: (ctx) => ContainerPage(),
};

final Route<dynamic> Function(RouteSettings settings) onGenerateRoute = (settings) {
  WidgetBuilder builder;

  // if (settings.name == BookDetailPage.pagename) {
  //   builder = (context) => BookDetailPage(maps: settings.arguments);
  // }

  return MaterialPageRoute(
    settings: RouteSettings(
      name: settings.name,
      arguments: settings.arguments,
    ),
    builder: (context) {
      return builder(context);
    },
  );
};

final Route<dynamic> Function(RouteSettings settings) onUnknownRoute = (settings) {
  return MaterialPageRoute(
    builder: (context) {
      return NotFoundPage();
    },
  );
};
