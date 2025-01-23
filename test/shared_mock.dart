import 'package:expense_tracker/core/api/TrxApi.dart';
import 'package:expense_tracker/core/repository/trx_repository.dart';
import 'package:mockito/annotations.dart';
@GenerateNiceMocks([MockSpec<TrxRepository>(), MockSpec<TrxApi>()])
class SharedMock{}