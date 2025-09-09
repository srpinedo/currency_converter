//
//  LocalizationManager.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import Foundation
import SwiftUI

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    
    @Published var currentLanguage: Language = .english
    
    private init() {
        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage"),
           let language = Language(rawValue: savedLanguage) {
            currentLanguage = language
        }
    }
    
    func setLanguage(_ language: Language) {
        currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: "selectedLanguage")
        UserDefaults.standard.synchronize()
        
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    func localizedString(_ key: String, _ arguments: CVarArg...) -> String {
        let bundle = Bundle.main
        let path = bundle.path(forResource: currentLanguage.rawValue, ofType: "lproj") ?? bundle.path(forResource: "en", ofType: "lproj")
        let languageBundle = Bundle(path: path ?? bundle.bundlePath)
        
        let format = languageBundle?.localizedString(forKey: key, value: key, table: nil) ?? key
        return String(format: format, arguments: arguments)
    }
}

enum Language: String, CaseIterable {
    case english = "en"
    case spanish = "es"
    
    var displayName: String {
        switch self {
        case .english:
            return NSLocalizedString("english", comment: "")
        case .spanish:
            return NSLocalizedString("spanish", comment: "")
        }
    }
    
    var flag: String {
        switch self {
        case .english:
            return "🇺🇸"
        case .spanish:
            return "🇪🇸"
        }
    }
}

// MARK: - String Extension for Localization
extension String {
    func localized(_ arguments: CVarArg...) -> String {
        return LocalizationManager.shared.localizedString(self, arguments)
    }
}
