import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';

enum SupportedLanguageEasyLocalization { en, fr }

extension SupportedLanguageEasyLocalizationExtension
    on SupportedLanguageEasyLocalization {
  String get title {
    switch (this) {
      case SupportedLanguageEasyLocalization.en:
        return LocaleKeys.settings_english.tr();
      case SupportedLanguageEasyLocalization.fr:
        return LocaleKeys.settings_french.tr();
    }
  }
}

SupportedLanguageEasyLocalization
    getSupportedLanguageEasyLocalizationFromString(String language) =>
        SupportedLanguageEasyLocalization.values.firstWhere(
          (f) => f.name == language,
          orElse: () => SupportedLanguageEasyLocalization.fr,
        );
