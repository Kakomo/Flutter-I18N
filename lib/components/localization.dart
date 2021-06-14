import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super("spa");
}

class LocalizationContainer extends StatelessWidget {
  final Widget child;

  LocalizationContainer({@required Widget this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: this.child,
    );
  }
}

class ViewI18N {
  var _language;

  ViewI18N(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }
}

class DashboardViewi18N extends ViewI18N {
  DashboardViewi18N(BuildContext context) : super(context);

  String localize(Map<String, String> values) {
    assert(values != null);
    assert(values.containsKey(_language));
    return values[_language];
  }

  String transfer() {
    return localize({
      "en": "Transfer",
      "pt-br": "Transferir",
      "spa": "Transferir",
      "de": "Transfer",
      "ja": "Tensō"
    });
  }

  String transactionFeed() {
    return localize({
      "en": "Transaction Feed",
      "pt-br": "Transações",
      "spa": "Feed de Transacciones",
      "de": "Transaktions-Feed",
      "ja": "Toranzakushonfīdo"
    });
  }

  String changeName() {
    return localize({
      "en": "Change Name",
      "pt-br": "Mudar Nome",
      "spa": "Cambiar Nombre",
      "de": "Namen Ändern",
      "ja": "Namae o henkō suru"
    });
  }
}
