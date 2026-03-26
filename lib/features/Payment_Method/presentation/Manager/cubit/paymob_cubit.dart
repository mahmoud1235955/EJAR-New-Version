import 'package:bloc/bloc.dart';
import 'package:ejar/core/Paymob_constants/Paymob_constants.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
part 'paymob_state.dart';

class PaymobCubit extends Cubit<PaymobState> {
  PaymobCubit() : super(PaymobInitial());
  Dio dio = Dio();

  Future<void> paymob({
    required String amount,
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
  }) async {
    try {
      emit(PaymobAuthLoading());

      // الخطوة 1: Auth Token
      Response authRes = await dio.post(
        "${PaymobConstants.baseUrl}/auth/tokens",
        data: {"api_key": PaymobConstants.apiKey},
      );
      String token = authRes.data["token"];

      // الخطوة 2: Order ID (تم تصحيح ecommerce)
      Response orederRes = await dio.post(
        "${PaymobConstants.baseUrl}/ecommerce/orders", // مصلحة هنا بـ double 'm'
        data: {
          "auth_token": token,
          "delivery_needed": "false",
          "amount_cents": amount,
          "currency": "EGP",
          "items": [], // لو مش محتاج تفاصيل سيبها فاضية أضمن
        },
      );
      String orderId = orederRes.data["id"].toString();

      // الخطوة 3: Final Payment Token
      Response finalKeyRes = await dio.post(
        '${PaymobConstants.baseUrl}/acceptance/payment_keys',
        data: {
          "auth_token": token, // تأكد إنك باعت الـ token الأول هنا
          "amount_cents": amount,
          "expiration": 3600,
          "order_id": orderId,
          "billing_data": {
            "apartment": "NA",
            "email": email,
            "floor": "NA",
            "first_name": firstName,
            "street": "NA",
            "building": "NA",
            "phone_number": phone,
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "last_name": lastName,
            "state": "NA",
          },
          "currency": "EGP",
          "integration_id": PaymobConstants.cardIntegrationId,
        },
      );

      String finalToken = finalKeyRes.data['token'];
      emit(PaymobSuccess(finalToken));
    } on DioException catch (e) {
      // تفاصيل أكتر عن الخطأ لو حصل من السيرفر
      emit(PaymobError(e.response?.data.toString() ?? e.message!));
    } catch (e) {
      emit(PaymobError(e.toString()));
    }
  }
}
