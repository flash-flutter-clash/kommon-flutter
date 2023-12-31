import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KCircleChartItem {
  Color colors;
  double values;
  String titles;

  KCircleChartItem(this.colors, this.values, this.titles);
}

class KCircleChart extends StatelessWidget {
  final List<KCircleChartItem> items;
  final double? width;
  final double height;
  final Rx<BrnDoughnutDataItem?> selectedObs = Rx(null);
  final int ringWidth;
  final bool showLegend;
  final bool showTitleOnlyWhenSelected;
  final double fontSize;
  final Orientation orientation;

  KCircleChart(
      {Key? key,
      required this.items,
      this.width,
      this.ringWidth = 50,
      required this.height,
      this.showLegend = false,
      this.showTitleOnlyWhenSelected = false,
      this.fontSize = 12,
      this.orientation = Orientation.landscape})
      : super(key: key);

  List<BrnDoughnutDataItem> getDataItem() {
    return items.map((item) {
      return BrnDoughnutDataItem(
          value: item.values, color: item.colors, title: item.titles);
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final items = getDataItem();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => BrnDoughnutChart(
              data: getDataItem(),
              width: width ?? Get.width,
              height: height,
              ringWidth: ringWidth,
              selectedItem: selectedObs.value,
              fontSize: fontSize,
              showTitleWhenSelected: showTitleOnlyWhenSelected,
              selectCallback: (s) {
                selectedObs.value = s;
              },
            ),
          ),
          showLegend
              ? DoughnutChartLegend(
                  data: items,
                  legendStyle: BrnDoughnutChartLegendStyle.wrap,
                ).paddingOnly(top: 8.0)
              : const Offstage()
        ],
      ),
    );
  }
}
