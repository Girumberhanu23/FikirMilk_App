import 'package:fikir_milk/homeScreen/data/homeRepository.dart';
import 'package:fikir_milk/homeScreen/data/models/supplierModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class SupplierListBloc extends Bloc<SupplierListEvent, SupplierListState> {
  HomeRepository homeRepository;

  SupplierListBloc(this.homeRepository) : super(SupplierListInitial()) {
    on<GetSupplierListEvent>(_onGetSupplierListEvent);
  }

  void _onGetSupplierListEvent(GetSupplierListEvent event, Emitter emit) async {
    emit(SupplierListLoading());
    try {
      final supplier = await homeRepository.getSuppliers();
      emit(SupplierListSuccess(supplier));
    } catch (e) {
      emit(SupplierListFailure(e.toString()));
    }
  }
}
