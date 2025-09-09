//
//  CurrencyConverterViewModel.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import Foundation
import SwiftUI

@MainActor
class CurrencyConverterViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var fromCurrency: Currency
    @Published var toCurrency: Currency
    @Published var amount: String = "1"
    @Published var exchangeRate: Double = 0.0
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var lastUpdateTime: Date?
    
    // MARK: - Private Properties
    private let currencyService: CurrencyService
    
    // MARK: - Computed Properties
    var convertedAmount: Double {
        guard let amountValue = Double(amount) else { return 0 }
        return amountValue * exchangeRate
    }
    
    var formattedConvertedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 4
        return formatter.string(from: NSNumber(value: convertedAmount)) ?? "0.00"
    }
    
    var formattedExchangeRate: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 4
        return formatter.string(from: NSNumber(value: exchangeRate)) ?? "0.00"
    }
    
    var amountLabel: String {
        "amount_label".localized(fromCurrency.code)
    }
    
    var exchangeRateText: String {
        "1 \(fromCurrency.code) = \(formattedExchangeRate) \(toCurrency.code)"
    }
    
    var resultText: String {
        "\(formattedConvertedAmount) \(toCurrency.code)"
    }
    
    // MARK: - Initialization
    init(currencyService: CurrencyService = CurrencyService()) {
        self.currencyService = currencyService
        self.fromCurrency = Currency.currencies.first { $0.code == "USD" } ?? Currency.currencies[0]
        self.toCurrency = Currency.currencies.first { $0.code == "COP" } ?? Currency.currencies[20]
        
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        // Bind to currency service
        currencyService.$exchangeRate
            .assign(to: &$exchangeRate)
        
        currencyService.$isLoading
            .assign(to: &$isLoading)
        
        currencyService.$errorMessage
            .assign(to: &$errorMessage)
        
        currencyService.$lastUpdateTime
            .assign(to: &$lastUpdateTime)
    }
    
    // MARK: - Public Methods
    func swapCurrencies() {
        let temp = fromCurrency
        fromCurrency = toCurrency
        toCurrency = temp
    }
    
    func updateExchangeRate() {
        Task {
            await currencyService.fetchExchangeRate(from: fromCurrency.code, to: toCurrency.code)
        }
    }
    
    func setAmount(_ value: String) {
        amount = value
    }
    
    func clearAmount() {
        amount = ""
    }
    
    func loadInitialData() {
        updateExchangeRate()
    }
}