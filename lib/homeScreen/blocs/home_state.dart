part of 'home_bloc.dart';

abstract class SupplierListState {}

class SupplierListInitial extends SupplierListState {}

class SupplierListLoading extends SupplierListState {}

class SupplierListSuccess extends SupplierListState {
  final Suppliers supplier;
  SupplierListSuccess(this.supplier);
}

class SupplierListFailure extends SupplierListState {
  final String error;
  SupplierListFailure(this.error);
}
