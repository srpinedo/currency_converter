//
//  CurrencySelectionView.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import SwiftUI

struct CurrencySelectionView: View {
    @Binding var fromCurrency: Currency
    @Binding var toCurrency: Currency
    @State private var showingFromPicker = false
    @State private var showingToPicker = false
    @EnvironmentObject var localizationManager: LocalizationManager
    
    let onSwap: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            // From currency
            CurrencyPickerButton(
                currency: fromCurrency,
                label: "from_label".localized(),
                isShowing: $showingFromPicker
            )
            
            // Swap button
            Button(action: onSwap) {
                Image(systemName: "arrow.left.arrow.right")
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            
            // To currency
            CurrencyPickerButton(
                currency: toCurrency,
                label: "to_label".localized(),
                isShowing: $showingToPicker
            )
        }
        .sheet(isPresented: $showingFromPicker) {
            CurrencyPickerView(selectedCurrency: $fromCurrency, title: "select_currency_origin".localized())
        }
        .sheet(isPresented: $showingToPicker) {
            CurrencyPickerView(selectedCurrency: $toCurrency, title: "select_currency_destination".localized())
        }
    }
}

struct CurrencyPickerButton: View {
    let currency: Currency
    let label: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Button(action: { isShowing = true }) {
                HStack {
                    Text(currency.flag)
                    Text(currency.code)
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.caption)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .foregroundColor(.primary)
        }
    }
}
