//
//  CurrencyModel.swift
//  CryptoApp
//
//  Created by Mehmet Jiyan Atalay on 6.04.2024.
//

import Foundation

struct CurrencyModel: Codable {
    let rates: [String: Double]
}

struct SymbolModel : Codable {
    let symbols : [String : String]
}
