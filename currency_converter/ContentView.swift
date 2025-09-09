//
//  ContentView.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    @StateObject private var localizationManager = LocalizationManager.shared
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(spacing: 20) {
                    HStack {
                        Text("app_title".localized())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        LanguageToggleView()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    CurrencySelectionView(
                        fromCurrency: $viewModel.fromCurrency,
                        toCurrency: $viewModel.toCurrency,
                        onSwap: viewModel.swapCurrencies
                    )
                    .environmentObject(localizationManager)
                    
                    AmountInputView(
                        amount: $viewModel.amount,
                        currencyCode: viewModel.fromCurrency.code,
                        onAmountSet: viewModel.setAmount,
                        onAmountClear: viewModel.clearAmount
                    )
                    .environmentObject(localizationManager)
                    
                    QuickAmountButtonsView { value in
                        viewModel.setAmount(value)
                    }
                    
                    ExchangeRateView(
                        exchangeRateText: viewModel.exchangeRateText,
                        resultText: viewModel.resultText
                    )
                    .environmentObject(localizationManager)
                    
                    UpdateButtonView(
                        isLoading: viewModel.isLoading,
                        onUpdate: viewModel.updateExchangeRate
                    )
                    .environmentObject(localizationManager)
                    
                    Text("source".localized())
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 10)
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            viewModel.loadInitialData()
        }
        .onChange(of: viewModel.fromCurrency) { _ in
            viewModel.updateExchangeRate()
        }
        .onChange(of: viewModel.toCurrency) { _ in
            viewModel.updateExchangeRate()
        }
        .onChange(of: localizationManager.currentLanguage) { _ in
            viewModel.objectWillChange.send()
        }
    }
}

#Preview {
    ContentView()
}
