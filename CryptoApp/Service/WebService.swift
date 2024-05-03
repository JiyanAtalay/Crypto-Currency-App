//
//  WebService.swift
//  CryptoApp
//
//  Created by Mehmet Jiyan Atalay on 5.04.2024.
//

import Foundation

class WebService {
    func downloadCryptoCurrencies(url : URL) async throws -> [Datum] {
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        let currencies = try? JSONDecoder().decode(Welcome.self, from: data)
        
        return currencies?.data ?? []
    }
    
    func downloadCurrencies(url : URL) async throws -> [String : Double] {
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        let rates = try? JSONDecoder().decode(CurrencyModel.self, from: data)
        
        return rates?.rates ?? [:]
        
    }
    
    func downloadSymbols(url : URL) async throws -> [String : String] {
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        let symbols = try? JSONDecoder().decode(SymbolModel.self, from: data)
        
        return symbols?.symbols ?? [:]
    }
}
