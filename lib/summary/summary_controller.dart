import 'package:expense_tracker/core/controller/base_controller.dart';
import 'package:expense_tracker/core/model/calendar_filter.dart';
import 'package:expense_tracker/core/model/trx.dart';
import 'package:expense_tracker/core/model/trx_by_category.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:get/get.dart';
import "package:collection/collection.dart";

class SummaryController extends BaseController {
  static SummaryController get to => Get.find();
  final trxRepository = Get.find<TrxRepository>();
  List<Trx> trxList = [];
  final filteredTrxList = Rx<List<Trx>>([]);
  final trxByCategoryList = Rx<List<TrxByCategory>>([]);
  final calendarFilter = CalendarFilter.week.obs;

  @override
  onInit() {
    super.onInit();
    _getLatestTrxList();
  }

  _getLatestTrxList() async {
    try {
      loading();
      trxRepository.getTrxList().listen((event) {
        trxList = event;
        updateFilter();
        success();
      });
    } catch (e) {
      error(error: e.toString());
    }
  }

  updateFilter({CalendarFilter? calendarFilterValue}) {
    if (calendarFilterValue != null) {
      calendarFilter.value = calendarFilterValue;
    }
    filteredTrxList.value = trxList.where((trx) {
      final today = DateTime.now();
      final startDate = today.subtract(Duration(days: calendarFilter.value.numOfDays));
      return trx.dateTime.isAfter(startDate) && trx.dateTime.isBefore(today);
    }).toList();
    calendarFilter.refresh();
    filteredTrxList.refresh();
    _updateTrxByCategoryList();
  }

  get summary => filteredTrxList.value.fold(0.0, (sum, item) => sum + item.amount);

  _updateTrxByCategoryList() {
    List<TrxByCategory> trxByCategoryList = [];
    var group = groupBy(filteredTrxList.value, (Trx obj) => obj.category);
    double totalAllTrx = summary;
    group.forEach((category, list) {
      trxByCategoryList.add(TrxByCategory(category, list, totalAllTrx));
    });
    trxByCategoryList.sort((a,b) => b.totalAmount.compareTo(a.totalAmount));
    this.trxByCategoryList.value = trxByCategoryList;
    this.trxByCategoryList.refresh();
  }
}
