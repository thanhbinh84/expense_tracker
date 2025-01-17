import 'package:expense_tracker/core/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final bool resizeToAvoidBottomPadding;
  final Future<bool>? onWillPop;
  final BaseController? controller;
  final String? title;
  final FloatingActionButton? floatingActionButton;

  const BaseScreen(this.body,
      {super.key,
      this.controller,
      this.resizeToAvoidBottomPadding = false,
      this.onWillPop,
      this.floatingActionButton,
      this.title});

  @override
  Widget build(BuildContext context) {
    return controller != null ? _childWithController(context) : _child(context);
  }

  _childWithController(ctx) {
    return controller?.obx((state) => _child(ctx),
        onLoading: Stack(
          children: [_child(ctx), _loadingIndicator],
        ),
        onEmpty: const Text('No data found'),
        onError: (error) => _child(ctx));
  }

  get _loadingIndicator => Positioned.fill(
          child: Container(
        color: Colors.black54,
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white.withAlpha(80),
          ),
        ),
      ));

  _child(ctx) => Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
        appBar: title == null ? null : _appBar(ctx),
        body: SafeArea(child: body),
        floatingActionButton: floatingActionButton,
      );

  _appBar(ctx) =>
      AppBar(title: Text(title!), backgroundColor: Theme.of(ctx).colorScheme.inversePrimary);
}
