import 'i18n_localizations.dart';

extension I18nStringExt on String {
  String i18n({List<String>? params}) {
    final key = this;
    final localization = I18nLocalizations();
    var value = localization.getValue(key);

    if (params != null) {
      for (var i = 0; i < params.length; i++) {
        value = value.replaceAll("\$$i", params[i]);
      }
    }
    return value;
  }
}
