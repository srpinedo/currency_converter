//
//  CurrencyPickerView.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import SwiftUI

struct CurrencyPickerView: View {
    @Binding var selectedCurrency: Currency
    let title: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(Currency.currencies) { currency in
                HStack {
                    Text(currency.flag)
                    Text(currency.code)
                        .fontWeight(.medium)
                    Text(currency.name)
                        .foregroundColor(.secondary)
                    Spacer()
                    if currency.id == selectedCurrency.id {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCurrency = currency
                    dismiss()
                }
            }
            .navigationTitle(title)
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
