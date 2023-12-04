part of 'home_bloc.dart';

abstract class SupplierListEvent {}

class GetSupplierListEvent extends SupplierListEvent {}

abstract class CreateSupplierEvent {}

class PostSupplierEvent extends CreateSupplierEvent {
  final CreateSupplier addSupplier;
  PostSupplierEvent(this.addSupplier);
}

abstract class UpdateSupplierEvent {}

class PatchSupplierEvent extends UpdateSupplierEvent {
  final UpdateSupplier updateSupplier;

  PatchSupplierEvent(this.updateSupplier);
}

abstract class DeleteSupplierEvent {}

class OnDeleteSupplierEvent extends DeleteSupplierEvent {
  final String? deleteSupplier;
  OnDeleteSupplierEvent(this.deleteSupplier);
}
