//
//  CurrencyData.swift
//  currency_converter
//
//  Created by Joan Pinedo on 8/09/25.
//

import Foundation

struct Currency: Identifiable, Hashable {
    let id = UUID()
    let code: String
    let name: String
    let flag: String
    
    static let currencies = [
        Currency(code: "USD", name: "US Dollar", flag: "🇺🇸"),
        Currency(code: "EUR", name: "Euro", flag: "🇪🇺"),
        Currency(code: "GBP", name: "British Pound", flag: "🇬🇧"),
        Currency(code: "JPY", name: "Japanese Yen", flag: "🇯🇵"),
        Currency(code: "CAD", name: "Canadian Dollar", flag: "🇨🇦"),
        Currency(code: "AUD", name: "Australian Dollar", flag: "🇦🇺"),
        Currency(code: "CHF", name: "Swiss Franc", flag: "🇨🇭"),
        Currency(code: "CNY", name: "Chinese Yuan", flag: "🇨🇳"),
        Currency(code: "SEK", name: "Swedish Krona", flag: "🇸🇪"),
        Currency(code: "NZD", name: "New Zealand Dollar", flag: "🇳🇿"),
        Currency(code: "MXN", name: "Mexican Peso", flag: "🇲🇽"),
        Currency(code: "SGD", name: "Singapore Dollar", flag: "🇸🇬"),
        Currency(code: "HKD", name: "Hong Kong Dollar", flag: "🇭🇰"),
        Currency(code: "NOK", name: "Norwegian Krone", flag: "🇳🇴"),
        Currency(code: "TRY", name: "Turkish Lira", flag: "🇹🇷"),
        Currency(code: "RUB", name: "Russian Ruble", flag: "🇷🇺"),
        Currency(code: "INR", name: "Indian Rupee", flag: "🇮🇳"),
        Currency(code: "BRL", name: "Brazilian Real", flag: "🇧🇷"),
        Currency(code: "ZAR", name: "South African Rand", flag: "🇿🇦"),
        Currency(code: "KRW", name: "South Korean Won", flag: "🇰🇷"),
        Currency(code: "COP", name: "Colombian Peso", flag: "🇨🇴"),
        Currency(code: "ARS", name: "Argentine Peso", flag: "🇦🇷"),
        Currency(code: "CLP", name: "Chilean Peso", flag: "🇨🇱"),
        Currency(code: "PEN", name: "Peruvian Sol", flag: "🇵🇪"),
        Currency(code: "UYU", name: "Uruguayan Peso", flag: "🇺🇾"),
        Currency(code: "VES", name: "Venezuelan Bolívar", flag: "🇻🇪"),
        Currency(code: "BOL", name: "Bolivian Boliviano", flag: "🇧🇴"),
        Currency(code: "PYG", name: "Paraguayan Guarani", flag: "🇵🇾"),
        Currency(code: "GTQ", name: "Guatemalan Quetzal", flag: "🇬🇹"),
        Currency(code: "HNL", name: "Honduran Lempira", flag: "🇭🇳"),
        Currency(code: "NIO", name: "Nicaraguan Córdoba", flag: "🇳🇮"),
        Currency(code: "CRC", name: "Costa Rican Colón", flag: "🇨🇷"),
        Currency(code: "PAB", name: "Panamanian Balboa", flag: "🇵🇦"),
        Currency(code: "DOP", name: "Dominican Peso", flag: "🇩🇴"),
        Currency(code: "CUP", name: "Cuban Peso", flag: "🇨🇺"),
        Currency(code: "JMD", name: "Jamaican Dollar", flag: "🇯🇲"),
        Currency(code: "TTD", name: "Trinidad and Tobago Dollar", flag: "🇹🇹"),
        Currency(code: "BBD", name: "Barbadian Dollar", flag: "🇧🇧"),
        Currency(code: "BZD", name: "Belize Dollar", flag: "🇧🇿"),
        Currency(code: "XCD", name: "East Caribbean Dollar", flag: "🇦🇬"),
        Currency(code: "AWG", name: "Aruban Florin", flag: "🇦🇼"),
        Currency(code: "ANG", name: "Netherlands Antillean Guilder", flag: "🇳🇱"),
        Currency(code: "SRD", name: "Surinamese Dollar", flag: "🇸🇷"),
        Currency(code: "GYD", name: "Guyanese Dollar", flag: "🇬🇾")
    ]
}