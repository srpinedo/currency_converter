//
//  ExchangeRateView.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import SwiftUI

struct ExchangeRateView: View {
    let exchangeRateText: String
    let resultText: String
    
    var body: some View {
        VStack(spacing: 20) {
            // Exchange rate
            VStack(alignment: .leading, spacing: 5) {
                Text("current_rate".localized())
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(exchangeRateText)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Result
            VStack(alignment: .leading, spacing: 5) {
                Text("result".localized())
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(resultText)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct UpdateButtonView: View {
    let isLoading: Bool
    let onUpdate: () -> Void
    
    var body: some View {
        Button(action: onUpdate) {
            HStack {
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Image(systemName: "arrow.clockwise")
                }
                Text("update_rate".localized())
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .disabled(isLoading)
    }
}
