import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:oural_go/data/repository/data_repository.dart';

part 'favorite_items_state.dart';

class FavoriteItemsCubit extends Cubit<FavoriteItemsState> {
  FavoriteItemsCubit() : super(const FavoriteItemsState(favoriteItems: [])) {
    initializeTickers();
  }

  DataRepository dr = DataRepository();

  void initializeTickers() async {
    List<Map<String, dynamic>> items = await dr.getAllTickers();
    emit(FavoriteItemsState(favoriteItems: items));
  }

  void addTicker(String ticker) async {
    await dr.insertTicker(ticker);
    List<Map<String, dynamic>> items = await dr.getAllTickers();
    emit(FavoriteItemsState(favoriteItems: items));
  }

  void deleteTicker(String ticker) async {
    await dr.deleteTicker(ticker);
    List<Map<String, dynamic>> items = await dr.getAllTickers();
    emit(FavoriteItemsState(favoriteItems: items));
  }
}
