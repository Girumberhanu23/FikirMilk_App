part of 'home_bloc.dart';

abstract class SupplierListState {}

class SupplierListInitial extends SupplierListState {}

class SupplierListLoading extends SupplierListState {}

class SupplierListSuccess extends SupplierListState {
  final List<Suppliers> supplier;
  SupplierListSuccess(this.supplier);
}

class SupplierListFailure extends SupplierListState {
  final String error;
  SupplierListFailure(this.error);
}

abstract class CreateSupplierState {}

class CreateSupplierInitial extends CreateSupplierState {}

class CreateSupplierLoading extends CreateSupplierState {}

class CreateSupplierSuccess extends CreateSupplierState {}

class CreateSupplierFailure extends CreateSupplierState {
  final String error;
  CreateSupplierFailure(this.error);
}

abstract class UpdateSupplierState {}

class UpdateSupplierInitial extends UpdateSupplierState {}

class UpdateSupplierLoading extends UpdateSupplierState {}

class UpdateSupplierSuccess extends UpdateSupplierState {}

class UpdateSupplierFailure extends UpdateSupplierState {
  final String error;

  UpdateSupplierFailure(this.error);
}

abstract class DeleteSupplierState {}

class DeleteSupplierInitial extends DeleteSupplierState {}

class DeleteSupplierLoading extends DeleteSupplierState {}

class DeleteSupplierSuccess extends DeleteSupplierState {}

class DeleteSupplierFailure extends DeleteSupplierState {
  final String error;
  DeleteSupplierFailure(this.error);
}
