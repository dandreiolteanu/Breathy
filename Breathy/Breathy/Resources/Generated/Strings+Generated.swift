// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum BreathingExercisesList {
    /// Good Afternoon, %@
    internal static func afternoonTitle(_ p1: Any) -> String {
      return L10n.tr("Localizable", "BreathingExercisesList.afternoonTitle", String(describing: p1))
    }
    /// Breathy is doing it’s best to produce new breathing exercises.
    internal static let comingSoonSubtitle = L10n.tr("Localizable", "BreathingExercisesList.comingSoonSubtitle")
    /// More coming soon...
    internal static let comingSoonTitle = L10n.tr("Localizable", "BreathingExercisesList.comingSoonTitle")
    /// Good Evening, %@
    internal static func eveningTitle(_ p1: Any) -> String {
      return L10n.tr("Localizable", "BreathingExercisesList.eveningTitle", String(describing: p1))
    }
    /// Good Morning, %@
    internal static func morningTitle(_ p1: Any) -> String {
      return L10n.tr("Localizable", "BreathingExercisesList.morningTitle", String(describing: p1))
    }
    /// Start relaxing with our breathing exercises
    internal static let subtitle = L10n.tr("Localizable", "BreathingExercisesList.subtitle")
  }

  internal enum BreathingInfo {
    /// Increase Happiness
    internal static let happinessTitle = L10n.tr("Localizable", "BreathingInfo.happinessTitle")
    /// Better Sleep
    internal static let sleepTitle = L10n.tr("Localizable", "BreathingInfo.sleepTitle")
    /// Reduce Stress
    internal static let stressTitle = L10n.tr("Localizable", "BreathingInfo.stressTitle")
  }

  internal enum BreathingSession {
    /// Exhale
    internal static let exhale = L10n.tr("Localizable", "BreathingSession.exhale")
    /// Get Ready
    internal static let getReady = L10n.tr("Localizable", "BreathingSession.getReady")
    /// Hold
    internal static let hold = L10n.tr("Localizable", "BreathingSession.hold")
    /// Inhale
    internal static let inhale = L10n.tr("Localizable", "BreathingSession.inhale")
    /// We recommend practicing breathwork while sitting or lying down. If you feel lightheaded, please stop immediately. Do not practice while driving or in water.
    internal static let warning = L10n.tr("Localizable", "BreathingSession.warning")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
