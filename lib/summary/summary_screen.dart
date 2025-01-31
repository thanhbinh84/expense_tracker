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
                CalendarSegment(),
                SummaryCircleView(),
                GroupByCategoryLabel(),
                CategoryListView(),
              ],
            ),
          ),
        ));
  }
}

class GroupByCategoryLabel extends StatelessWidget {
  const GroupByCategoryLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(Txt.byCategory,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: SummaryController.to.trxSumByCategoryList.value.length,
        itemBuilder: (BuildContext context, int index) {
          final trx = SummaryController.to.trxSumByCategoryList.value[index];
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

class CalendarSegment extends StatelessWidget {
  const CalendarSegment({super.key});

  @override
  Widget build(BuildContext context) {
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
              SummaryController.to.calendarFilter.value
            },
            onSelectionChanged: (Set<CalendarFilter> newSelection) {
              SummaryController.to.updateFilter(calendarFilterValue: newSelection.first);
            })));
  }
}

class SummaryCircleView extends StatelessWidget {
  const SummaryCircleView({super.key});

  @override
  Widget build(BuildContext context) {
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
                              text: '€${SummaryController.to.summary}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 40)),
                          TextSpan(
                              text:
                                  '\n${Txt.last} ${SummaryController.to.calendarFilter.value.name.toLowerCase()}')
                        ]))
              ],
            )),
      ),
    );
  }
}
