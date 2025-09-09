//
//  AmountInputView.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import SwiftUI

struct AmountInputView: View {
    @Binding var amount: String
    let currencyCode: String
    let onAmountSet: (String) -> Void
    let onAmountClear: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("amount_label".localized(currencyCode))
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                TextField("0", text: $amount)
                    .keyboardType(.decimalPad)
                    .font(.title3)
                    .fontWeight(.medium)
                    .onChange(of: amount) {
                        onAmountSet(amount)
                    }
                
                if !amount.isEmpty {
                    Button(action: onAmountClear) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct QuickAmountButtonsView: View {
    let onAmountSet: (String) -> Void
    
    private let quickAmounts = ["10", "50", "100"]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(quickAmounts, id: \.self) { value in
                Button(action: { onAmountSet(value) }) {
                    Text(value)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
