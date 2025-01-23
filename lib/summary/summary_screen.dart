import 'package:expense_tracker/core/model/calendar_filter.dart';
import 'package:expense_tracker/core/util/const/txt.dart';
import 'package:expense_tracker/core/widget/base_screen.dart';
import 'package:expense_tracker/summary/summary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryScreen extends GetView<SummaryController> {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: 'Expense Summary',
        controller: controller,
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _calendarSegment(context),
                _summaryCircleView(context),
                _groupByCategoryLabel(context),
                _categoryListView(context),
              ],
            ),
          ),
        ));
  }

  Widget _calendarSegment(BuildContext context) {
    return Obx(() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 15),
        child: SegmentedButton<CalendarFilter>(
            segments: <ButtonSegment<CalendarFilter>>[
              ButtonSegment<CalendarFilter>(
                  value: CalendarFilter.week,
                  label: Text(CalendarFilter.week.name),
                  icon: Icon(Icons.calendar_view_day)),
              ButtonSegment<CalendarFilter>(
                  value: CalendarFilter.month,
                  label: Text(CalendarFilter.month.name),
                  icon: Icon(Icons.calendar_view_week)),
              ButtonSegment<CalendarFilter>(
                  value: CalendarFilter.year,
                  label: Text(CalendarFilter.year.name),
                  icon: Icon(Icons.calendar_view_month))
            ],
            selected: <CalendarFilter>{
              controller.calendarFilter.value
            },
            onSelectionChanged: (Set<CalendarFilter> newSelection) {
              controller.updateFilter(calendarFilterValue: newSelection.first);
            })));
  }

  Widget _summaryCircleView(BuildContext context) {
    final circleDiameter = Get.width * 0.7;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        width: circleDiameter,
        height: circleDiameter,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.inversePrimary, width: 15)),
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: '${Txt.spent}\n',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                              text: '€${controller.summary}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 40)),
                          TextSpan(
                              text:
                                  '\n${Txt.last} ${controller.calendarFilter.value.name.toLowerCase()}')
                        ]))
              ],
            )),
      ),
    );
  }

  Widget _groupByCategoryLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(Txt.byCategory,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  _categoryListView(context) {
    return Obx(() => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.trxByCategoryList.value.length,
        itemBuilder: (BuildContext context, int index) {
          final trx = controller.trxByCategoryList.value[index];
          return Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: SizedBox(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                leading: Icon(trx.category.iconData),
                title: Text(trx.category.name),
                subtitle: Text(trx.totalTrxString),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(trx.totalAmountString, style: Theme.of(context).textTheme.bodyLarge),
                    Text(trx.percentString, style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
