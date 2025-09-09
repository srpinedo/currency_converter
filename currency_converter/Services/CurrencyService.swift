//
//  CurrencyService.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let result: String
    let documentation: String
    let termsOfUse: String
    let timeLastUpdateUnix: Int
    let timeLastUpdateUtc: String
    let timeNextUpdateUnix: Int
    let timeNextUpdateUtc: String
    let baseCode: String
    let targetCode: String
    let conversionRate: Double
    
    enum CodingKeys: String, CodingKey {
        case result
        case documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUtc = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUtc = "time_next_update_utc"
        case baseCode = "base_code"
        case targetCode = "target_code"
        case conversionRate = "conversion_rate"
    }
}

struct CurrencyRatesResponse: Codable {
    let result: String
    let documentation: String
    let termsOfUse: String
    let timeLastUpdateUnix: Int
    let timeLastUpdateUtc: String
    let timeNextUpdateUnix: Int
    let timeNextUpdateUtc: String
    let baseCode: String
    let conversionRates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case result
        case documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUtc = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUtc = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}

class CurrencyService: ObservableObject {
    private let apiKey = "2a2fd3dfcb50e444d3e2a07f"
    private let baseURL = "https://v6.exchangerate-api.com/v6"
    
    @Published var exchangeRate: Double = 0.0
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var lastUpdateTime: Date?
    
    func fetchExchangeRate(from: String, to: String) async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        let urlString = "\(baseURL)/\(apiKey)/pair/\(from)/\(to)"
        
        guard let url = URL(string: urlString) else {
            await MainActor.run {
                errorMessage = "Invalid URL"
                isLoading = false
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
            
            await MainActor.run {
                self.exchangeRate = response.conversionRate
                self.lastUpdateTime = Date()
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error fetching exchange rate: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    func fetchAllRates(baseCurrency: String) async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        let urlString = "\(baseURL)/\(apiKey)/latest/\(baseCurrency)"
        
        guard let url = URL(string: urlString) else {
            await MainActor.run {
                errorMessage = "Invalid URL"
                isLoading = false
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let _ = try JSONDecoder().decode(CurrencyRatesResponse.self, from: data)
            
            await MainActor.run {
                self.lastUpdateTime = Date()
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Error fetching exchange rates: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}