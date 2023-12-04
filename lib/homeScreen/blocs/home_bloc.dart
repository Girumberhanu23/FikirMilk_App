import 'package:fikir_milk/homeScreen/data/homeRepository.dart';
import 'package:fikir_milk/homeScreen/data/models/createSupplier.dart';
import 'package:fikir_milk/homeScreen/data/models/supplierModel.dart';
import 'package:fikir_milk/homeScreen/data/models/updateSupplier.dart';
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

class CreateSupplierBloc
    extends Bloc<CreateSupplierEvent, CreateSupplierState> {
  HomeRepository homeRepository;
  CreateSupplierBloc(this.homeRepository) : super(CreateSupplierInitial()) {
    on<PostSupplierEvent>(_onCreateSupplierEvent);
  }

  void _onCreateSupplierEvent(PostSupplierEvent event, Emitter emit) async {
    emit(CreateSupplierLoading());
    try {
      await homeRepository.createSupplier(event.addSupplier);
      emit(CreateSupplierSuccess());
    } catch (e) {
      print(e);
      emit(CreateSupplierFailure(e.toString()));
    }
  }
}

class UpdateSupplierBloc
    extends Bloc<UpdateSupplierEvent, UpdateSupplierState> {
  final HomeRepository homeRepository;

  UpdateSupplierBloc(this.homeRepository) : super(UpdateSupplierInitial()) {
    on<PatchSupplierEvent>(_onPatchSupplierEvent);
  }

  void _onPatchSupplierEvent(
    PatchSupplierEvent event,
    Emitter<UpdateSupplierState> emit,
  ) async {
    emit(UpdateSupplierLoading());
    try {
      await homeRepository.updateSupplier(event.updateSupplier);
      emit(UpdateSupplierSuccess());
    } catch (e) {
      emit(UpdateSupplierFailure(e.toString()));
    }
  }
}

class DeleteSupplierBloc
    extends Bloc<DeleteSupplierEvent, DeleteSupplierState> {
  HomeRepository homeRepository;
  DeleteSupplierBloc(this.homeRepository) : super(DeleteSupplierInitial()) {
    on<OnDeleteSupplierEvent>(_onDeleteSupplierEvent);
  }
  void _onDeleteSupplierEvent(OnDeleteSupplierEvent event, Emitter emit) async {
    emit(DeleteSupplierLoading());
    try {
      await homeRepository.deleteSupplier(event.deleteSupplier);
      emit(DeleteSupplierSuccess());
    } catch (e) {
      emit(DeleteSupplierFailure(e.toString()));
    }
  }
}
