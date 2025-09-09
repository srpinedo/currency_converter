//
//  LanguageToggleView.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import SwiftUI

struct LanguageToggleView: View {
    @StateObject private var localizationManager = LocalizationManager.shared
    @State private var showingLanguagePicker = false
    
    var body: some View {
        Button(action: { showingLanguagePicker = true }) {
            HStack(spacing: 8) {
                Text(localizationManager.currentLanguage.flag)
                    .font(.title2)
                Text(localizationManager.currentLanguage.displayName)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.blue.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .sheet(isPresented: $showingLanguagePicker) {
            LanguagePickerView()
        }
    }
}

struct LanguagePickerView: View {
    @StateObject private var localizationManager = LocalizationManager.shared
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(Language.allCases, id: \.self) { language in
                HStack {
                    Text(language.flag)
                        .font(.title2)
                    Text(language.displayName)
                        .fontWeight(.medium)
                    Spacer()
                    if language == localizationManager.currentLanguage {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    localizationManager.setLanguage(language)
                    dismiss()
                }
            }
            .navigationTitle("language".localized())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("close".localized()) {
                        dismiss()
                    }
                }
            }
        }
    }
}
