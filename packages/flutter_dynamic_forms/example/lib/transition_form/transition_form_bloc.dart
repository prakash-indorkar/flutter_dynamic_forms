import 'package:bloc/bloc.dart';
import 'package:dynamic_forms/dynamic_forms.dart';
import 'package:example/transition_form/transition_form_event.dart';
import 'package:example/transition_form/transition_form_state.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dynamic_forms/flutter_dynamic_forms.dart';

class TransitionFormBloc extends Bloc<FormElementEvent, TransitionFormState> {
  final FormManagerBuilder formManagerBuilder;

  FormManager formManager;

  TransitionFormBloc(this.formManagerBuilder);

  @override
  TransitionFormState get initialState => TransitionFormState();

  @override
  Stream<TransitionFormState> mapEventToState(FormElementEvent event) async* {
    if (event is LoadFormEvent) {
      yield currentState.copyWith(isLoading: true);

      await Future.delayed(Duration(seconds: 1));
      var xml =
          await rootBundle.loadString("assets/test_form1.xml", cache: false);
      formManager = formManagerBuilder.build(xml);

      yield currentState.copyWith(
          isLoading: false,
          isValid: formManager.isFormValid,
          form: formManager.form);
      return;
    }

    if (event is ClearFormEvent) {
      formManager.resetForm();
      yield currentState.copyWith(
          isLoading: false,
          isValid: formManager.isFormValid,
          form: formManager.form);
      return;
    }

    if (event is RequestFormDataEvent) {
      yield currentState.copyWith(
          isLoading: false,
          isValid: formManager.isFormValid,
          form: formManager.form,
          resultItemValues: formManager.getFormData());
      return;
    }

    if (event is ClearFormDataEvent) {
      yield currentState.copyWith(
          isLoading: false,
          isValid: formManager.isFormValid,
          form: formManager.form,
          resultItemValues: List<FormItemValue>());
      return;
    }

    if (event is ChangeValueEvent) {
      if (event is ChangeValueEvent<int>) {
        formManager.changeValue(
            event.value, event.formElementId, event.propertyName);
      }
      if (event is ChangeValueEvent<String>) {
        formManager.changeValue(
            event.value, event.formElementId, event.propertyName);
      }
      if (event is ChangeValueEvent<bool>) {
        formManager.changeValue(
            event.value, event.formElementId, event.propertyName);
      }
      if (event is ChangeValueEvent<double>) {
        formManager.changeValue(
            event.value, event.formElementId, event.propertyName);
      }
      yield currentState.copyWith(isValid: formManager.isFormValid);
    }
  }
}
