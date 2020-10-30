import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:test_app/utils/color_util.dart';
import 'package:test_app/utils/adapt.dart';

///收起键盘的点击事件
mixin ClearFocusOnTap {
  GestureDetector clearFocusGestureDetector({
    @required BuildContext context,
    @required FocusNode blankNode,
    @required Widget child,
    Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(blankNode);
        if (onTap != null) {
          onTap();
        }
      },
      child: child,
    );
  }
}

///简单加载框
mixin SimpleLoading {
  void showLoading({@required BuildContext context, String msg, bool canCancel = false}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        ///屏蔽返回键
        return WillPopScope(
          child: Dialog(
            backgroundColor: Color(0xddffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            insetPadding: EdgeInsets.all(120),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: CupertinoActivityIndicator(),
            ),
          ),
          onWillPop: () async {
            return Future.value(canCancel);
          },
        );
      },
    );
  }

  void dismissLoadingDialog({@required BuildContext context}) {
    Navigator.pop(context);
  }
}

///分享底部弹出框
mixin ShareBottomSheet {
  void showShareBottomSheet({
    @required BuildContext context,
    @required String title,
    @required List<Widget> shareItems,
  }) {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.w),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.w,
                    color: AppColors.hex333333,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: AppColors.hex333333,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 40.w,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: shareItems,
                ),
              ),
              Divider(
                height: 1,
                color: AppColors.hex333333,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  height: 80.w,
                  alignment: Alignment.center,
                  child: Text(
                    "关闭",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.w,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// shareItem(
  ///   img: "${Constant.ASSETS_IMG}share_icon_b_1.png",
  ///   text: "朋友圈",
  ///   onTap: () {
  ///     print("分享：朋友圈");
  ///   },
  /// ),
  /// shareItem(
  ///   img: "${Constant.ASSETS_IMG}share_icon_b_2.png",
  ///   text: "微信",
  ///   onTap: () {
  ///     print("分享：微信");
  ///   },
  /// ),
  /// shareItem(
  ///   img: "${Constant.ASSETS_IMG}share_icon_b_3.png",
  ///   text: "QQ",
  ///   onTap: () {
  ///     print("分享：QQ");
  ///   },
  /// ),
  /// shareItem(
  ///   img: "${Constant.ASSETS_IMG}share_icon_b_4.png",
  ///   text: "QQ空间",
  ///   onTap: () {
  ///     print("分享：QQ空间");
  ///   },
  /// ),
  Widget shareItem({
    String img,
    String text,
    Function onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Image.asset(
              img,
              width: 100.w,
              height: 100.w,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 25.w,
            ),
            Text(
              text,
              style: TextStyle(
                color: AppColors.hex333333,
                fontSize: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///自定义dialog
mixin CustomizeDialog {
  ///
  /// @barrierDismissible 可取消弹框，默认可取消
  ///
  Future<void> showCustomizeDialog({
    @required BuildContext context,
    @required Widget dialog,
    bool barrierDismissible = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          child: dialog,
          onWillPop: () async {
            return Future.value(barrierDismissible);
          },
        );
      },
    );
  }

  void dismissDialog({@required BuildContext context}) {
    Navigator.pop(context);
  }
}

///排序
mixin CustomizeSort {
  /// qr sign 加密排序
  String sortSignParam(Map<String, dynamic> params) {
    if (params.isNotEmpty) {
      List<MapEntry<String, dynamic>> conversionList = params.entries.toList();
      conversionList.sort((a, b) {
        return a.key.compareTo(b.key);
      });
      StringBuffer buffer = StringBuffer();
      for (int i = 0; i < conversionList.length; i++) {
        buffer.write("${conversionList[i].key}=${conversionList[i].value}");
        if (i != conversionList.length - 1) {
          buffer.write("&");
        }
      }
      return buffer.toString();
    } else {
      return null;
    }
  }
}

///屏幕渲染第一帧后
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}
