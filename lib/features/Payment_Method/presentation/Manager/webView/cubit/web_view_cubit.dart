import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'web_view_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit() : super(WebViewInitial());
}
