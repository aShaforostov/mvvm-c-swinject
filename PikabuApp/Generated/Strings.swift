// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Выберите сортировку
  internal static let chooseSort = L10n.tr("Localizable", "choose_sort")
  /// Раскрыть
  internal static let expand = L10n.tr("Localizable", "expand")
  /// Сначала новые
  internal static let sortDateNew = L10n.tr("Localizable", "sort_date_new")
  /// Сначала старые
  internal static let sortDateOld = L10n.tr("Localizable", "sort_date_old")
  /// Без сортировки
  internal static let sortNone = L10n.tr("Localizable", "sort_none")
  /// Сначала популярные
  internal static let sortRatingBig = L10n.tr("Localizable", "sort_rating_big")
  /// Сначала непопулярные
  internal static let sortRatingLowest = L10n.tr("Localizable", "sort_rating_lowest")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
