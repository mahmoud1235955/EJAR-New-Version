import 'package:bloc/bloc.dart';
import 'package:ejar/features/MyProducts/presentation/Models/myProduct_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'my_product_state.dart';

class MyProductCubit extends Cubit<MyProductState> {
  SupabaseClient supabase = Supabase.instance.client;
  MyProductCubit() : super(MyProductInitial());

  List<MyproductModel> myProduct = [];
  Future<void> getMyProduct() async {
    emit(MyProductLoading());
    try {
      final data = await supabase
          .from("products")
          .select()
          .eq("user_id", supabase.auth.currentUser!.id);
      if (isClosed) return;
      myProduct = data.map((e) => MyproductModel.fromJson(e)).toList();
      emit(MyProductSuccess(products: myProduct));
    } on AuthException catch (e) {
      emit(MyProductError(message: e.message));
    } catch (e) {
      emit(MyProductError(message: e.toString()));
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      emit(MyProductLoading());
      await supabase.from("products").delete().eq("id", id);
      emit(MyProductSuccess(products: myProduct));
    } on AuthException catch (e) {
      emit(MyProductError(message: e.message));
    } catch (e) {
      emit(MyProductError(message: e.toString()));
    }
  }

  Future<void> updateProduct() async {
    try {
      emit(MyProductLoading());
      await supabase.from("table");
      emit(MyProductSuccess(products: myProduct));
    } on AuthException catch (e) {
      emit(MyProductError(message: e.message));
    } catch (e) {
      emit(MyProductError(message: e.toString()));
    }
  }
}
