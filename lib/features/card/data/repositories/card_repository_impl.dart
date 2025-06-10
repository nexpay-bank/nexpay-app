import 'package:nexpay/features/card/data/datasources/remote/card_remote_data_source.dart';
import 'package:nexpay/features/card/data/repositories/card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource dataSource;

  CardRepositoryImpl(this.dataSource);

  @override
  Future<void> create() {
    return dataSource.create();
  }

  @override
  Future<void> get() {
    return dataSource.get();
  }
}
